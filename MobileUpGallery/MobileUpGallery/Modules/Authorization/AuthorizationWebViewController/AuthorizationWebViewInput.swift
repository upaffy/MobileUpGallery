//
//  AuthorizationWebViewInput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 26.04.2023.
//

import Foundation

protocol AuthorizationWebViewInput: AnyObject {
    func loadURL(url: URL)
    func setLoading(enabled: Bool)
    func showOKAlert(title: String, message: String?)
    func showCancelAlert(title: String, message: String?, cancelActionTitle: String)
}
