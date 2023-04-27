//
//  KeyChainServiceProtocol.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

protocol KeyChainServiceProtocol {
    func set(value: String, for key: String)
    func getValue(by key: String) -> String?
    func deleteValue(by key: String)
}
