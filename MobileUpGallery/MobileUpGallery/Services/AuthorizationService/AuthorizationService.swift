//
//  AuthorizationService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class AuthorizationService: AuthorizationServiceProtocol {
    
    private enum VKOAuth {
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let authorizePath = "/authorize"
        static let clientID = "51624940"
        static let redirectURI = "https://oauth.vk.com/blank.html"
        static let responseRelativePath = "/blank.html"
        static let responseType = "token"
        static let responseFieldsCount = 3
        static let accessTokenField = "access_token"
        static let expiresInField = "expires_in"
        static let userIDField = "user_id"
        static let expireDateField = "expire_date"
    }
    
    private let keychainService: KeyChainServiceProtocol
    
    init(keychainService: KeyChainServiceProtocol) {
        self.keychainService = keychainService
    }
    
    func getOAuthVKURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = VKOAuth.scheme
        urlComponents.host = VKOAuth.host
        urlComponents.path = VKOAuth.authorizePath
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: VKOAuth.clientID),
            URLQueryItem(name: "redirect_uri", value: VKOAuth.redirectURI),
            URLQueryItem(name: "response_type", value: VKOAuth.responseType)
        ]
        
        return urlComponents.url
    }
    
    func fetchNecessaryTokenInfoElseNil(from url: URL) -> [String: String]? {
        guard
            url.scheme == VKOAuth.scheme,
            url.relativePath == VKOAuth.responseRelativePath,
            let fragments = url.fragment?.components(separatedBy: "&"),
            fragments.count == VKOAuth.responseFieldsCount
        else {
            return nil
        }
        
        var infoDict: [String: String] = [:]
        
        for fragment in fragments {
            let elementInfo = fragment.components(separatedBy: "=")
            
            guard elementInfo.count == 2 else { return nil }
            let field = elementInfo[0]
            let value = elementInfo[1]
            
            if [VKOAuth.accessTokenField, VKOAuth.userIDField].contains(field) {
                infoDict[field] = value
            } else if field == VKOAuth.expiresInField {
                let tokenLifeTime = Double(value) ?? 0
                infoDict[VKOAuth.expireDateField] = String(
                    Date(timeIntervalSinceNow: .zero).timeIntervalSince1970 + tokenLifeTime
                )
            }
        }
        
        guard
            infoDict[VKOAuth.accessTokenField] != nil,
            infoDict[VKOAuth.expiresInField] != nil,
            infoDict[VKOAuth.userIDField] != nil
        else {
            return nil
        }

        return infoDict
    }
    
    func saveTokenInfo(_ tokenInfo: [String: String]) {
        for (key, value) in tokenInfo {
            keychainService.set(value: value, for: key)
        }
    }
}
