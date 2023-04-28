//
//  ServiceAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class ServiceAssembly {

    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService.shared
    }()

    func makeAuthorizationService() -> AuthorizationServiceProtocol {
        AuthorizationService(keychainService: makeKeyChainService())
    }
    
    func makeKeyChainService() -> KeyChainServiceProtocol {
        KeyChainService()
    }
    
    func makePhotoCollectionService() -> PhotoCollectionServiceProtocol {
        PhotoCollectionService(networkService: networkService)
    }
    
    func makeImageService() -> ImageServiceProtocol {
        ImageService.shared
    }
}
