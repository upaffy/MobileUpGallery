//
//  AuthorizationService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class AuthorizationService: AuthorizationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
