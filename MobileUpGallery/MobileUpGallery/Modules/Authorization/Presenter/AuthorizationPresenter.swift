//
//  AuthorizationPresenter.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class AuthorizationPresenter {
    
    private weak var moduleOutput: AuthorizationModuleOutput?
    private let authorizationService: AuthorizationServiceProtocol
    weak var viewInput: AuthorizationViewInput?
    
    init(moduleOutput: AuthorizationModuleOutput? = nil, authorizationService: AuthorizationServiceProtocol) {
        self.moduleOutput = moduleOutput
        self.authorizationService = authorizationService
    }
}

extension AuthorizationPresenter: AuthorizationViewOutput {
    
}
