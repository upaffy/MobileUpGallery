//
//  ImageService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

final class ImageService: ImageServiceProtocol {
    
    static let shared = ImageService()
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    private init() {}
    
    func fetchImageData(from url: URL, usingCache: Bool, completion: @escaping (Data?) -> Void) {
        guard usingCache else {
            fetchNetworkData(from: url) { data in
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            return
        }
        
        getCachedImageData(by: url) { [weak self] data in
            if let data {
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                self?.fetchNetworkData(from: url, completion: { data in
                    if let data {
                        self?.cacheImageData(data, by: url)
                    }
                    DispatchQueue.main.async {
                        completion(data)
                    }
                })
                return
            }
        }
    }
    
    private func cacheImageData(_ data: Data, by url: URL) {
        guard var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let appendingPath = String(url.path.dropFirst()).replacingOccurrences(of: "/", with: "")
        path.appendPathComponent(appendingPath)
        
        DispatchQueue.global().async {
            try? data.write(to: path)
        }
    }
    
    private func getCachedImageData(by url: URL, completion: @escaping (Data?) -> Void) {
        guard var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil)
            return
        }

        let appendingPath = String(url.path.dropFirst()).replacingOccurrences(of: "/", with: "")
        path.appendPathComponent(appendingPath)
        
        var downloadSession: URLSessionDownloadTask?
        
        if FileManager.default.fileExists(atPath: path.path) {
            downloadSession = URLSession.shared.downloadTask(with: path) { sessionURL, _, error in
                if error != nil {
                    completion(nil)
                    return
                }
                
                guard
                    let sessionURL,
                    let data = try? Data(contentsOf: sessionURL)
                else {
                    completion(nil)
                    return
                }
                
                completion(data)
            }
        } else {
            completion(nil)
        }
        
        downloadSession?.resume()
    }
    
    private func fetchNetworkData(from url: URL, completion: @escaping (Data?) -> Void) {
        networkService.fetchImageData(from: url) { data, responseURL in
            guard let data, let responseURL, responseURL == url else {
                completion(nil)
                return
            }
            
            completion(data)
        }
    }
}
