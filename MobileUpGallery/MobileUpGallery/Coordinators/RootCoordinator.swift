//
//  RootCoordinator.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

final class RootCoordinator {

    private weak var window: UIWindow?

    private let authorizationAssembly: AuthorizationAssembly
    
    init(authorizationAssembly: AuthorizationAssembly) {
        self.authorizationAssembly = authorizationAssembly
    }

    func start(in window: UIWindow) {
        let vc = authorizationAssembly.makeAuthorizationModule(moduleOutput: self)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: - Navigation

}

extension RootCoordinator: AuthorizationModuleOutput {

}
