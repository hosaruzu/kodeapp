//
//  AppAssembly.swift
//  kodeapp
//
//  Created by Artem Tebenkov on 16.03.2024.
//

import UIKit

final class AppAssembly {

    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactory

    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
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

    func makePeopleScreen() -> PeopleViewController
    func makeProfileScreen() -> ProfileViewController
    func makeCallPhoneAlert(with phoneNumber: String) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {

    @MainActor
    func makePeopleScreen() -> PeopleViewController {
        let viewModel = PeopleViewViewModel()
        let viewController = PeopleViewController(viewModel: viewModel)

        return viewController
    }

    @MainActor
    func makeProfileScreen() -> ProfileViewController {
        let viewModel = ProfileViewViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }

    func makeCallPhoneAlert(with phoneNumber: String) -> UIViewController {
        let application = UIApplication.shared
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let phoneNumberFormatted = phoneNumber.formatToPhoneNumber()

        let callPhoneButton = UIAlertAction(title: "\(phoneNumberFormatted)", style: .default) { _ in
            let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if let phoneCallURL = URL(string: "tel://+7\(cleanedPhoneNumber)"),
               application.canOpenURL(phoneCallURL) {
                print("Will be call \(cleanedPhoneNumber)")
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
