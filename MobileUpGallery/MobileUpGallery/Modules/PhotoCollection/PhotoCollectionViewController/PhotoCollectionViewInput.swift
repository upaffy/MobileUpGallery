//
//  PhotoCollectionViewInput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

protocol PhotoCollectionViewInput: AnyObject {
    func setupUI(with mainTitle: String, and logoutButtonTitle: String)
    func showData(_ data: [PhotoCollectionViewCell.CellConfigurationData])
    func setLoading(enabled: Bool)
    func showAlert(title: String, message: String?, completion: @escaping () -> Void)
}
