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
    
    init(loginAssembly: LoginAssembly) {
        self.loginAssembly = loginAssembly
    }

    func start(in window: UIWindow) {
        let vc = loginAssembly.makeLoginModule(moduleOutput: self)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: - Navigation

}

extension RootCoordinator: LoginModuleOutput {

}
