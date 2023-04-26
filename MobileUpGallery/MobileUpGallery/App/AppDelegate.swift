//
//  AppDelegate.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 24.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let serviceAssembly = ServiceAssembly()
        coordinator = RootCoordinator(
            loginAssembly: LoginAssembly(serviceAssembly: serviceAssembly)
        )
        coordinator?.start(in: window)

        return true
    }
}
