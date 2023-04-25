//
//  AuthorizationAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

final class AuthorizationAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeAuthorizationModule(moduleOutput: AuthorizationModuleOutput) -> UIViewController {
        let presenter = AuthorizationPresenter(
            moduleOutput: moduleOutput,
            authorizationService: serviceAssembly.makeAuthorizationService()
        )
        let vc = AuthorizationViewController(viewOutput: presenter)
        presenter.viewInput = vc
        
        return vc
    }
}
