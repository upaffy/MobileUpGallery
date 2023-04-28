//
//  PhotoCollectionServiceProtocol.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

protocol PhotoCollectionServiceProtocol {
    func getPhotosList(authToken: String, _ completion: @escaping (Result<[PhotoModel], VKErrorModel>) -> Void)
}
