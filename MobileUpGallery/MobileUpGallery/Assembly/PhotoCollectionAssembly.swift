//
//  PhotoCollectionAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import UIKit

final class PhotoCollectionAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makePhotoCollectionModule(moduleOutput: PhotoCollectionModuleOutput, authToken: String) -> UIViewController {
        let presenter = PhotoCollectionPresenter(
            authorizationService: serviceAssembly.makeAuthorizationService(),
            photoCollectionService: serviceAssembly.makePhotoCollectionService(), 
            moduleOutput: moduleOutput,
            authToken: authToken
        )
        let vc = PhotoCollectionViewController(viewOutput: presenter)
        presenter.viewInput = vc
        
        return vc
    }
}
