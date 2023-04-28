//
//  PhotoDetailsPresenter.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

final class PhotoDetailsPresenter {
    
    private weak var moduleOutput: PhotoDetailsModuleOutput?
    weak var viewInput: PhotoDetailsViewInput?
    
    private let imageService: ImageServiceProtocol
    private let photo: PhotoModel
    
    init(
        moduleOutput: PhotoDetailsModuleOutput?,
        imageService: ImageServiceProtocol,
        photo: PhotoModel
    ) {
        self.moduleOutput = moduleOutput
        self.imageService = imageService
        self.photo = photo
    }
}

// MARK: - PhotoDetailsModuleOutput

extension PhotoDetailsPresenter: PhotoDetailsViewOutput {
    func viewIsReady() {
        viewInput?.setLoading(enabled: true)
        imageService.fetchImageData(from: photo.url, usingCache: true) { [weak self] data in
            self?.viewInput?.setLoading(enabled: false)
            if let data {
                self?.viewInput?.showImage(with: data)
            } else {
                self?.viewInput?.showAlert(
                    title: NSLocalizedString("standard_error_title", comment: ""),
                    message: NSLocalizedString("standard_error_message", comment: "")
                )
            }
        }
        
        guard let date = photo.date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let dateString = dateFormatter.string(from: date)
        viewInput?.setupUI(with: dateString)
    }
}
