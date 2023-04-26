//
//  LoginAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

final class LoginAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeLoginModule(moduleOutput: LoginModuleOutput) -> UIViewController {
        let presenter = LoginPresenter(
            moduleOutput: moduleOutput
        )
        let vc = LoginViewController(viewOutput: presenter)
        presenter.viewInput = vc
        
        return vc
    }
}
