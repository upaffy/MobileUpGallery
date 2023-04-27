//
//  RootCoordinator.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

final class RootCoordinator {

    private weak var window: UIWindow?

    private let loginAssembly: LoginAssembly
    private let authorizationAssembly: AuthorizationAssembly
    
    init(loginAssembly: LoginAssembly, authorizationAssembly: AuthorizationAssembly) {
        self.loginAssembly = loginAssembly
        self.authorizationAssembly = authorizationAssembly
    }

    func start(in window: UIWindow) {
        let vc = loginAssembly.makeLoginModule(moduleOutput: self)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}

// MARK: - LoginModuleOutput

extension RootCoordinator: LoginModuleOutput {
    func moduleWantsToOpenAuthorization() {
        let authorizationVC = authorizationAssembly.makeAuthorizationModule(moduleOutput: self)
        let navigationController = UINavigationController(rootViewController: authorizationVC)
        window?.rootViewController?.present(navigationController, animated: true)
    }
}

extension RootCoordinator: AuthorizationModuleOutput {
    func moduleWantsToDismiss() {
        window?.rootViewController?.presentedViewController?.dismiss(animated: true)
    }
}
