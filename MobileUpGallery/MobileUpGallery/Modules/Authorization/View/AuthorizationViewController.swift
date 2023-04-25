//
//  AuthorizationViewController.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private enum Constants {
        enum NameLabel {
            static let insets = UIEdgeInsets(top: 170, left: 24, bottom: 0, right: 24)
            static let font = UIFont.boldSystemFont(ofSize: 44)
            static let textColor = UIColor.black
        }
        
        enum AuthorizationButton {
            static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
            static let height: CGFloat = 52
            static let cornerRadius: CGFloat = 12
            static let tintColor = UIColor.white
            static let backgroundColor = UIColor.black
        }
    }
    
    private let viewOutput: AuthorizationViewOutput
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_name_label", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.NameLabel.font
        label.numberOfLines = 0
        label.textColor = Constants.NameLabel.textColor
        
        return label
    }()
    
    private lazy var authorizationButton: UIButton = {
        let button = UIButton()
        let title = NSLocalizedString("authorization_by_vk_button_title", comment: "")
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(authorizationButtonPressed), for: .touchUpInside)
        button.tintColor = Constants.AuthorizationButton.tintColor
        button.backgroundColor = Constants.AuthorizationButton.backgroundColor
        button.layer.cornerRadius = Constants.AuthorizationButton.cornerRadius
        
        return button
    }()

    init(viewOutput: AuthorizationViewOutput) {
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
        setupAuthorizationButton()
    }
}

// MARK: - Setup

extension AuthorizationViewController {
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
    
    private func setupAuthorizationButton() {
        view.addSubview(authorizationButton)
        NSLayoutConstraint.activate([
            authorizationButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.AuthorizationButton.insets.left
            ),
            authorizationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.AuthorizationButton.insets.right
            ),
            authorizationButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.AuthorizationButton.insets.bottom
            ),
            authorizationButton.heightAnchor.constraint(
                equalToConstant: Constants.AuthorizationButton.height
            )
        ])
    }
}

// MARK: - Logic

extension AuthorizationViewController {
    @objc private func authorizationButtonPressed() {
        
    }
}

// MARK: - AuthorizationViewInput

extension AuthorizationViewController: AuthorizationViewInput {
    
}
