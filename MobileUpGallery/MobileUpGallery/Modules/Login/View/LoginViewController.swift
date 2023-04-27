//
//  LoginViewController.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private enum Constants {
        enum NameLabel {
            static let insets = UIEdgeInsets(top: 170, left: 24, bottom: 0, right: 24)
            static let font = UIFont.boldSystemFont(ofSize: 44)
            static let textColor = UIColor.black
        }
        
        enum LoginButton {
            static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
            static let height: CGFloat = 52
            static let cornerRadius: CGFloat = 12
            static let tintColor = UIColor.white
            static let backgroundColor = UIColor.black
        }
    }
    
    private let viewOutput: LoginViewOutput
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_name_label", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.NameLabel.font
        label.numberOfLines = 0
        label.textColor = Constants.NameLabel.textColor
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSLocalizedString("authorization_by_vk_button_title", comment: "")
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.tintColor = Constants.LoginButton.tintColor
        button.backgroundColor = Constants.LoginButton.backgroundColor
        button.layer.cornerRadius = Constants.LoginButton.cornerRadius
        
        return button
    }()

    init(viewOutput: LoginViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNameLabel()
        setupLoginButton()
    }
}

// MARK: - Setup

extension LoginViewController {
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.NameLabel.insets.top
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.NameLabel.insets.left
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.NameLabel.insets.right
            )
        ])
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.LoginButton.insets.left
            ),
            loginButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.LoginButton.insets.right
            ),
            loginButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.LoginButton.insets.bottom
            ),
            loginButton.heightAnchor.constraint(
                equalToConstant: Constants.LoginButton.height
            )
        ])
    }
}

// MARK: - Logic

extension LoginViewController {
    @objc private func loginButtonPressed() {
        viewOutput.didPressLoginButton()
    }
}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {
    
}
