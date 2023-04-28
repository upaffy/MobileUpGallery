//
//  PhotoCollectionViewController.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    private enum Section {
      case main
    }
    
    private enum Constants {
        static let columnsCount: CGFloat = 2
        static let horizontalSpacing: CGFloat = 1
        static let verticalSpacing: CGFloat = 1.5
        static let okActionTitle = "OK"
    }
    
    private let viewOutput: PhotoCollectionViewOutput
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .init()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    init(viewOutput: PhotoCollectionViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupActivityIndicator()
        viewOutput.viewIsReady()
    }
}

// MARK: - Setup

extension PhotoCollectionViewController {
    private func setupCollectionView() {
        view.addSubview(photoCollectionView)
        photoCollectionView.dataSource = dataSource
        photoCollectionView.delegate = self
        photoCollectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.reusableIdentifier
        )
        configureCollectionLayout()
        
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionLayout() {
        
        let fraction: CGFloat = 1 / Constants.columnsCount
        
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fraction),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.verticalSpacing,
            leading: Constants.horizontalSpacing,
            bottom: Constants.verticalSpacing,
            trailing: Constants.horizontalSpacing
        )
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(fraction)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)

        photoCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavBar(with navBarTitle: String, and logoutButtonTitle: String) {
        title = navBarTitle
        let rightBarButtonItem = UIBarButtonItem(
            title: logoutButtonTitle,
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func didTapLogout() {
        viewOutput.didTapLogout()
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, PhotoCollectionViewCell.CellConfigurationData> {
        UICollectionViewDiffableDataSource(collectionView: photoCollectionView) { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCollectionViewCell.reusableIdentifier,
                for: indexPath
            ) as? PhotoCollectionViewCell
            
            cell?.configure(model)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewOutput.didSelectItem(at: indexPath.row)
    }
}

// MARK: - PhotoCollectionViewInput

extension PhotoCollectionViewController: PhotoCollectionViewInput {
    func setupUI(with mainTitle: String, and logoutButtonTitle: String) {
        setupNavBar(with: mainTitle, and: logoutButtonTitle)
    }
    
    func showData(_ data: [PhotoCollectionViewCell.CellConfigurationData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoCollectionViewCell.CellConfigurationData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setLoading(enabled: Bool) {
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showAlert(title: String, message: String?, completion: @escaping () -> Void) {
        let okAction = UIAlertAction(title: Constants.okActionTitle, style: .default) { _ in
            completion()
        }
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
}
