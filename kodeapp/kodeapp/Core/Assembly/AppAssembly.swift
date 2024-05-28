//
//  AppAssembly.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

final class AppAssembly {

    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    fileprivate let urlSession: URLSession
    fileprivate let urlCache: URLCache
    fileprivate let userDefaults: UserDefaults
    fileprivate let networkCacheService: NetworkCacheServiceImpl
    fileprivate let networkClient: NetworkClientImpl
    fileprivate let decoder: NetworkDecoderImpl
    fileprivate let request: NetworkRequstsImpl
    fileprivate let networkService: PeopleNetworkServiceImpl

    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)

        urlSession = .shared
        urlCache = .shared
        urlCache.memoryCapacity = 10_000_000 // ~10 MB memory space
        urlCache.diskCapacity = 1_000_000_000 // ~1GB disk cache space
        userDefaults = .standard
        decoder = NetworkDecoderImpl()
        request = NetworkRequstsImpl()
        networkCacheService = NetworkCacheServiceImpl(userDefaults: userDefaults, urlCache: urlCache)
        networkClient = NetworkClientImpl(urlSession: urlSession, cacheService: networkCacheService)
        networkService = PeopleNetworkServiceImpl(networkClient: networkClient, decoder: decoder, request: request)

        screenFactory.appAssembly = self
    }
}

protocol AppFactory {
    // Next: add cordinator
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension AppAssembly: AppFactory {

    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        let router = RouterImp(rootController: rootVC)
        let coordinator = coordinatorFactory.makeAppCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactory {

    func makePeopleScreen(coordinator: PeopleCoordinator) -> PeopleViewController
    func makeProfileScreen(with person: Person, coordinator: PeopleCoordinator) -> ProfileViewController
    func makeCallPhoneAlert(with phoneNumber: String) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {

    fileprivate weak var appAssembly: AppAssembly!
    fileprivate init() {}

    @MainActor
    func makePeopleScreen(coordinator: PeopleCoordinator) -> PeopleViewController {
        let viewModel = PeopleViewViewModel(networkService: appAssembly.networkService, coordinator: coordinator)
        let viewController = PeopleViewController(viewModel: viewModel)
        return viewController
    }

    @MainActor
    func makeProfileScreen(with person: Person, coordinator: PeopleCoordinator) -> ProfileViewController {
        let viewModel = ProfileViewViewModel(person: person, coordinator: coordinator)
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }

    func makeCallPhoneAlert(with phoneNumber: String) -> UIViewController {
        let application = UIApplication.shared
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let callPhoneButton = UIAlertAction(title: "\(phoneNumber)", style: .default) { _ in
            let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if let phoneCallURL = URL(string: "tel://+7\(cleanedPhoneNumber)"),
               application.canOpenURL(phoneCallURL) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                print("Can't open phone \(cleanedPhoneNumber)")
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.view.tintColor = AppConstants.Color.textPrimary
        alertController.addAction(callPhoneButton)
        alertController.addAction(cancelButton)
        return alertController
    }

    @MainActor
    func makeFilterScreen(with viewModel: PeopleViewViewModel) -> FilterViewController {
        let filterViewController = FilterViewController(viewModel: viewModel)
        return filterViewController
    }
}

protocol CoordinatorFactory {

    func makeAppCoordinator(router: Router) -> AppCoordinator
    func makePeopleCoordinator(router: Router) -> PeopleCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {

    private let screenFactory: ScreenFactory

    fileprivate init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    func makeAppCoordinator(router: Router) -> AppCoordinator {
        return AppCoordinator(coordinatorFactory: self, router: router)
    }

    func makePeopleCoordinator(router: Router) -> PeopleCoordinator {
        return PeopleCoordinator(screenFactory: screenFactory, router: router)
    }
}
