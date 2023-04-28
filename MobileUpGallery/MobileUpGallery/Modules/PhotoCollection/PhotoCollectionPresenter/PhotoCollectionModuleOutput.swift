//
//  PhotoCollectionModuleOutput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

protocol PhotoCollectionModuleOutput: AnyObject {
    func moduleWantsToOpenLogin()
    func moduleWantsToOpenPhotoDetails(with photo: PhotoModel)
}
