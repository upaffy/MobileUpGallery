//
//  AuthorizationWebViewOutput.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 26.04.2023.
//

import Foundation

protocol AuthorizationWebViewOutput {
    func viewIsReady()
    func didPressCancel()
    func didPressCancelAlertAction(shouldCancel: Bool)
    func startLoadPage()
    func didLoadPage(with url: URL?)
}
