//
//  PhotoCollectionViewOutput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

protocol PhotoCollectionViewOutput {
    func viewIsReady()
    func didTapLogout()
    func didSelectItem(at index: Int)
}
