//
//  ImageServiceProtocol.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImageData(from url: URL, usingCache: Bool, completion: @escaping (Data?) -> Void)
}
