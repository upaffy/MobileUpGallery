//
//  PhotoCollectionPresenter.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

final class PhotoCollectionPresenter {
    
    private enum Constants {
        static let authorizationErrorCode = 5
    }
    
    private weak var moduleOutput: PhotoCollectionModuleOutput?
    weak var viewInput: PhotoCollectionViewInput?
    
    private let authorizationService: AuthorizationServiceProtocol
    private let photoCollectionService: PhotoCollectionServiceProtocol
    private let authToken: String
    
    private var photos: [PhotoModel] = []
    
    init(
        authorizationService: AuthorizationServiceProtocol,
        photoCollectionService: PhotoCollectionServiceProtocol,
        moduleOutput: PhotoCollectionModuleOutput?,
        authToken: String
    ) {
        self.authorizationService = authorizationService
        self.photoCollectionService = photoCollectionService
        self.moduleOutput = moduleOutput
        self.authToken = authToken
    }
    
    private func loadData() {
        viewInput?.setLoading(enabled: true)
        
        photoCollectionService.getPhotosList(authToken: authToken) { [weak self] result in
            guard let self else {
                return
            }
            self.viewInput?.setLoading(enabled: false)
            switch result {
            case .success(let models):
                self.photos = models
                self.didLoad(photos: models)
            case .failure(let vkError):
                let title = vkError.errorMSG ?? NSLocalizedString("undefined_error_title", comment: "")
                self.viewInput?.showAlert(
                    title: title,
                    message: vkError.errorText
                ) {
                    if vkError.errorCode == Constants.authorizationErrorCode {
                        self.moduleOutput?.moduleWantsToOpenLogin()
                    }
                }
            }
        }
    }
    
    private func didLoad(photos: [PhotoModel]) {
        let configurationData = mapData(models: photos)
        viewInput?.showData(configurationData)
    }
    
    private func mapData(models: [PhotoModel]) -> [PhotoCollectionViewCell.CellConfigurationData] {
        models.map {
            PhotoCollectionViewCell.CellConfigurationData(photoURL: $0.url)
        }
    }
}

// MARK: - PhotoCollectionViewOutput

extension PhotoCollectionPresenter: PhotoCollectionViewOutput {
    func viewIsReady() {
        viewInput?.setupUI(
            with: NSLocalizedString("photo_collection_title", comment: ""),
            and: NSLocalizedString("logout_button_title", comment: "")
        )
        loadData()
    }
    
    func didTapLogout() {
        authorizationService.removeTokenInfo()
        moduleOutput?.moduleWantsToOpenLogin()
    }
    
    func didSelectItem(at index: Int) {
        guard photos.count > index else { return }
        let photo = photos[index]
        moduleOutput?.moduleWantsToOpenPhotoDetails(with: photo)
    }
}
