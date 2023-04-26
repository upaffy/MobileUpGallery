//
//  LoginPresenter.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class LoginPresenter {
    
    private weak var moduleOutput: LoginModuleOutput?
    weak var viewInput: LoginViewInput?
    
    init(moduleOutput: LoginModuleOutput? = nil) {
        self.moduleOutput = moduleOutput
    }
}

// MARK: - AuthorizationViewOutput

extension LoginPresenter: LoginViewOutput {
    func didPressLoginButton() {
        
    }
}
