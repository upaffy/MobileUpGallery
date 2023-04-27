//
//  AuthorizationAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 26.04.2023.
//

import UIKit

final class AuthorizationAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeAuthorizationModule(moduleOutput: AuthorizationModuleOutput) -> UIViewController {
        let presenter = AuthorizationPresenter(
            authorizationService: serviceAssembly.makeAuthorizationService(),
            moduleOutput: moduleOutput
        )
        let vc = AuthorizationViewController(viewOutput: presenter)
        presenter.viewInput = vc
        
        return vc
    }
}
