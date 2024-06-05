//
//  NetworkMonitor.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 05.06.2024.
//
import Network

protocol NetworkMonitor {
    var onConnectionStatusChange: ((Bool) -> Void)? { get set }
}

final class NetworkMonitorImpl: NetworkMonitor {

    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "monitor.network")

    var onConnectionStatusChange: ((Bool) -> Void)?

    init() {
        start()
    }

    func start() {
        networkMonitor.pathUpdateHandler = { path in
            Task {
                await self.setStatus(path.status == .satisfied)
            }
        }
        networkMonitor.start(queue: workerQueue)
    }

    func setStatus(_ status: Bool) async {
        await MainActor.run {
            self.onConnectionStatusChange?(status)
        }
    }
}
