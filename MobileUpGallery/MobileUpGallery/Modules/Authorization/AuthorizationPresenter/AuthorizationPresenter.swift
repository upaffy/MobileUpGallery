//
//  AuthorizationPresenter.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 26.04.2023.
//

import Foundation

final class AuthorizationPresenter {
    
    private weak var moduleOutput: AuthorizationModuleOutput?
    private let authorizationService: AuthorizationServiceProtocol

    weak var viewInput: AuthorizationWebViewInput?
    
    init(authorizationService: AuthorizationServiceProtocol, moduleOutput: AuthorizationModuleOutput?) {
        self.authorizationService = authorizationService
        self.moduleOutput = moduleOutput
    }
}

// MARK: - AuthorizationWebViewOutput

extension AuthorizationPresenter: AuthorizationWebViewOutput {
    func viewIsReady() {
        viewInput?.setLoading(enabled: true)
        guard let url = authorizationService.getOAuthVKURL() else {
            viewInput?.showOKAlert(
                title: NSLocalizedString("incorrect_url_alert_title", comment: ""),
                message: NSLocalizedString("try_again_alert_message", comment: "")
            )
            return
        }
        viewInput?.loadURL(url: url)
    }
    
    func didPressCancel() {
        viewInput?.showCancelAlert(
            title: NSLocalizedString("cancel_alert_title", comment: ""),
            message: NSLocalizedString("cancel_alert_message", comment: ""),
            cancelActionTitle: NSLocalizedString("cancel_title", comment: "")
        )
    }
    
    func didPressCancelAlertAction(shouldCancel: Bool) {
        if shouldCancel {
            moduleOutput?.moduleWantsToDismiss(withToken: nil)
        }
    }
    
    func startLoadPage() {
        viewInput?.setLoading(enabled: true)
    }
    
    func didLoadPage(with url: URL?) {
        viewInput?.setLoading(enabled: false)
        guard
            let url,
            let tokenInfo = authorizationService.fetchNecessaryTokenInfoElseNil(from: url)
        else {
            return
        }
        
        authorizationService.saveTokenInfo(tokenInfo)
        let token = authorizationService.getTokenIfExistAndValid()
        moduleOutput?.moduleWantsToDismiss(withToken: token)
    }
}
