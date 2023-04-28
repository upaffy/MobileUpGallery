//
//  RootCoordinator.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

final class RootCoordinator {

    private weak var window: UIWindow?
    
    private let authorizationService: AuthorizationServiceProtocol
    
    private let loginAssembly: LoginAssembly
    private let authorizationAssembly: AuthorizationAssembly
    private let photoCollectionAssembly: PhotoCollectionAssembly
    private let photoDetailsAssembly: PhotoDetailsAssembly
    
    private var navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController,
        authorizationService: AuthorizationServiceProtocol,
        loginAssembly: LoginAssembly,
        authorizationAssembly: AuthorizationAssembly,
        photoCollectionAssembly: PhotoCollectionAssembly,
        photoDetailsAssembly: PhotoDetailsAssembly
    ) {
        self.navigationController = navigationController
        self.authorizationService = authorizationService
        
        self.loginAssembly = loginAssembly
        self.authorizationAssembly = authorizationAssembly
        self.photoCollectionAssembly = photoCollectionAssembly
        self.photoDetailsAssembly = photoDetailsAssembly
    }

    func start(in window: UIWindow) {
        let vc: UIViewController
        if let authToken = authorizationService.getTokenIfExistAndValid() {
            vc = photoCollectionAssembly.makePhotoCollectionModule(moduleOutput: self, authToken: authToken)
        } else {
            vc = loginAssembly.makeLoginModule(moduleOutput: self)
        }
        
        navigationController.pushViewController(vc, animated: false)
        window.rootViewController = navigationController
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

// MARK: - AuthorizationModuleOutput

extension RootCoordinator: AuthorizationModuleOutput {
    func moduleWantsToDismiss(withToken authToken: String?) {
        window?.rootViewController?.presentedViewController?.dismiss(animated: true)
        guard let authToken else { return }
        
        let photoCollectionVC = photoCollectionAssembly.makePhotoCollectionModule(
            moduleOutput: self,
            authToken: authToken
        )
        navigationController.viewControllers = [photoCollectionVC]
    }
}

// MARK: - PhotoCollectionModuleOutput

extension RootCoordinator: PhotoCollectionModuleOutput {
    func moduleWantsToOpenLogin() {
        let loginVC = loginAssembly.makeLoginModule(moduleOutput: self)
        navigationController.viewControllers = [loginVC]
    }
    
    func moduleWantsToOpenPhotoDetails(with photo: PhotoModel) {
        let photoDetailsVC = photoDetailsAssembly.makePhotoDetailsModule(
            moduleOutput: self,
            photo: photo
        )
        navigationController.pushViewController(photoDetailsVC, animated: true)
    }
}

// MARK: - PhotoDetailsModuleOutput

extension RootCoordinator: PhotoDetailsModuleOutput {
    
}
