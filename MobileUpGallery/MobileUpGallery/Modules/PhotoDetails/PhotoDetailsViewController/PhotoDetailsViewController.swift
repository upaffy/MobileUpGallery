//
//  PhotoDetailsViewController.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    private enum Constants {
        static let shareIcon = UIImage(systemName: "square.and.arrow.up")
        static let okActionTitle = "OK"
    }
    
    private let viewOutput: PhotoDetailsViewOutput
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    init(viewOutput: PhotoDetailsViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupActivityIndicator()
        
        viewOutput.viewIsReady()
    }
    
    private func setupNavBar(with navBarTitle: String) {
        title = navBarTitle
        
        let rightBarButtonItem = UIBarButtonItem(
            image: Constants.shareIcon,
            style: .plain,
            target: self,
            action: #selector(shareDidTap)
        )
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func shareDidTap() {
        
    }
}

// MARK: - Setup

extension PhotoDetailsViewController {
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        imageView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}

// MARK: - PhotoDetailsViewInput

extension PhotoDetailsViewController: PhotoDetailsViewInput {
    func setupUI(with title: String) {
        setupNavBar(with: title)
    }
    
    func showImage(with data: Data) {
        imageView.image = UIImage(data: data)
    }
    
    func showAlert(title: String, message: String?) {
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default)
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
    
    func setLoading(enabled: Bool) {
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
