//
//  KeyChainService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation
import KeychainSwift

final class KeyChainService: KeyChainServiceProtocol {
    private let keychain = KeychainSwift()
    
    func set(value: String, for key: String) {
        keychain.set(value, forKey: key)
    }
    
    func getValue(by key: String) -> String? {
        keychain.get(key)
    }
    
    func deleteValue(by key: String) {
        keychain.delete(key)
    }
}
