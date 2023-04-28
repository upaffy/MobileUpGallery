//
//  PhotoCollectionViewCell.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let errorPlaceholderImage = UIImage(systemName: "staroflife.circle")
    }
    
    struct CellConfigurationData: Hashable {
        let photoURL: URL
    }
    
    static let reusableIdentifier = "PhotoCollectionViewCell"
    
    private let imageService = ImageService.shared
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        activityIndicator.center = contentView.center
    }
    
    func configure(_ model: CellConfigurationData) {
        activityIndicator.startAnimating()
        imageService.fetchImageData(from: model.photoURL, usingCache: true) { [weak self] imageData in
            self?.activityIndicator.stopAnimating()
            if let imageData, let image = UIImage(data: imageData) {
                self?.imageView.image = image
            } else {
                self?.imageView.image = Constants.errorPlaceholderImage
            }
        }
    }
}
