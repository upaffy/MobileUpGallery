//
//  AuthorizationServiceProtocol.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

protocol AuthorizationServiceProtocol {
    func getOAuthVKURL() -> URL?
    func fetchNecessaryTokenInfoElseNil(from url: URL) -> [String: String]?
    func saveTokenInfo(_ tokenInfo: [String: String])
    func removeTokenInfo()
    func getTokenIfExistAndValid() -> String?
}
