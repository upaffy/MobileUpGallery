//
//  PhotoDetailsAssembly.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import UIKit

final class PhotoDetailsAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makePhotoDetailsModule(moduleOutput: PhotoDetailsModuleOutput, photo: PhotoModel) -> UIViewController {
        let presenter = PhotoDetailsPresenter(
            moduleOutput: moduleOutput,
            imageService: serviceAssembly.makeImageService(),
            photo: photo
        )
        let vc = PhotoDetailsViewController(viewOutput: presenter)
        presenter.viewInput = vc
        
        return vc
    }
}
