//
//  AuthorizationViewController.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 26.04.2023.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    private enum Constants {
        static let okActionTitle = "OK"
    }
    
    private let viewOutput: AuthorizationWebViewOutput
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    init(viewOutput: AuthorizationWebViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        setupActivityIndicator()
        setupNavigationButtons()
        viewOutput.viewIsReady()
    }
}

// MARK: - Setup

extension AuthorizationViewController {
    private func setupWebView() {
        view.addSubview(webView)
        webView.navigationDelegate = self
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    @objc private func didTapCancel() {
        viewOutput.didPressCancel()
    }
}

// MARK: - WKNavigationDelegate

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        viewOutput.startLoadPage()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewOutput.didLoadPage(with: webView.url)
    }
}

// MARK: - LoginWebViewInput

extension AuthorizationViewController: AuthorizationWebViewInput {
    func loadURL(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    func setLoading(enabled: Bool) {
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showOKAlert(title: String, message: String?) {
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default)
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
    
    func showCancelAlert(title: String, message: String?, cancelActionTitle: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel) { [weak self] _ in
            self?.viewOutput.didPressCancelAlertAction(shouldCancel: false)
        }
        alertViewController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default) { [weak self] _ in
            self?.viewOutput.didPressCancelAlertAction(shouldCancel: true)
        }
        alertViewController.addAction(okAction)
        
        present(alertViewController, animated: true)
    }
}
