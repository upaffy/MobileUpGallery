//
//  PhotoCollectionService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

final class PhotoCollectionService: PhotoCollectionServiceProtocol {
    
    private enum Constants {
        enum VKRequestParams {
            static let scheme = "https"
            static let host = "api.vk.com"
            static let methodPath = "/method"
            static let getPhotosMethodPath = "/photos.get"
            static let apiVersionField = "v"
            static let apiVersion = "5.131"
            static let authorizationHeaderField = "Authorization"
            static let authorizationType = "Bearer"
        }
        
        enum AlbumParams {
            static let ownerIDField = "owner_id"
            static let ownerID = "-128666765"
            static let albumIDField = "album_id"
            static let albumID = "266310117"
        }
        
        static let customErrorCode = -1
    }
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getPhotosList(authToken: String, _ completion: @escaping (Result<[PhotoModel], VKErrorModel>) -> Void) {
        guard let url = getAlbumRequestURL() else {
            completion(.failure(VKErrorModel(
                errorCode: Constants.customErrorCode,
                errorMSG: NSLocalizedString("client_error_title", comment: ""),
                errorText: NSLocalizedString("wrong_request_params_error_message", comment: "")
            )))
            return
        }
        
        let standardError = ErrorAPIContainer(
            error: .init(
                errorCode: Constants.customErrorCode,
                errorMSG: NSLocalizedString("standard_error_title", comment: ""),
                errorText: NSLocalizedString("standard_error_message", comment: "")
            )
        )
        let mappedStandardError = mapErrorAPIContainerToVKErrorModel(standardError)
        
        let headers = getAlbumRequestHeaders(token: authToken)
        
        networkService.postRequest(
            url: url,
            headers: headers,
            postParams: [:],
            standardError: standardError
        ) { [weak self] (result: Result<PhotosListApiModel, ErrorAPIContainer>) in
            guard let self else { return }
            switch result {
            case .success(let photosAPIModel):
                guard let apiPhotos = photosAPIModel.photos else {
                    DispatchQueue.main.async {
                        completion(.failure(mappedStandardError))
                    }
                    return
                }
                let mappedPhotos = apiPhotos.compactMap({ photoAPIModel -> PhotoModel? in
                    self.mapAPIPhotoToPhotoModel(photoAPIModel)
                })
                
                DispatchQueue.main.async {
                    completion(.success(mappedPhotos))
                }
            case .failure(let errorAPIModel):
                DispatchQueue.main.async {
                    completion(.failure(self.mapErrorAPIContainerToVKErrorModel(errorAPIModel)))
                }
            }
        }
    }
    
    private func mapAPIPhotoToPhotoModel(_ apiPhoto: PhotosListApiModel.PhotoAPIModel) -> PhotoModel? {
        guard let id = apiPhoto.id, let sizes = apiPhoto.sizes else { return nil }
        guard let zSizePhoto = sizes.first(where: { $0.type == .z }), let url = zSizePhoto.url else {
            return nil
        }
        
        var date: Date?
        if let photoDateTimestamp = apiPhoto.date {
            date = Date(timeIntervalSince1970: photoDateTimestamp)
        }
        
        return PhotoModel(
            id: id,
            date: date,
            url: url
        )
    }
    
    private func mapErrorAPIContainerToVKErrorModel(_ errorAPIContainer: ErrorAPIContainer) -> VKErrorModel {
        if let apiError = errorAPIContainer.error {
            return VKErrorModel(
                errorCode: apiError.errorCode,
                errorMSG: apiError.errorMSG,
                errorText: apiError.errorText
            )
        } else {
            return VKErrorModel(errorCode: nil, errorMSG: nil, errorText: nil)
        }
    }
    
    private func getAlbumRequestURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.VKRequestParams.scheme
        urlComponents.host = Constants.VKRequestParams.host
        urlComponents.path = Constants.VKRequestParams.methodPath + Constants.VKRequestParams.getPhotosMethodPath
        urlComponents.queryItems = [
            URLQueryItem(
                name: Constants.AlbumParams.ownerIDField,
                value: Constants.AlbumParams.ownerID
            ),
            URLQueryItem(
                name: Constants.AlbumParams.albumIDField,
                value: Constants.AlbumParams.albumID
            ),
            URLQueryItem(
                name: Constants.VKRequestParams.apiVersionField,
                value: Constants.VKRequestParams.apiVersion
            )
        ]
        
        return urlComponents.url
    }
    
    private func getAlbumRequestHeaders(token: String) -> [String: String] {
        [Constants.VKRequestParams.authorizationHeaderField: "\(Constants.VKRequestParams.authorizationType) \(token)"]
    }
}
