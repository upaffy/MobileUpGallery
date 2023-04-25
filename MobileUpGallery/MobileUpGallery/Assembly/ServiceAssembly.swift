//
//  ServiceAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class ServiceAssembly {

    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService()
    }()

    func makeAuthorizationService() -> AuthorizationServiceProtocol {
        AuthorizationService(networkService: networkService)
    }
}
