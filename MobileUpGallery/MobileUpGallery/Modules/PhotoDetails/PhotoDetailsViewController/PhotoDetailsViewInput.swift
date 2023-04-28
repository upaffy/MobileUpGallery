//
//  PhotoDetailsViewInput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

protocol PhotoDetailsViewInput: AnyObject {
    func setupUI(with title: String)
    func setLoading(enabled: Bool)
    func showImage(with data: Data)
    func showAlert(title: String, message: String?)
}
