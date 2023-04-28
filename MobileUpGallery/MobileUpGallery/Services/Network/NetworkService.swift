//
//  NetworkService.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init() {}
    
    func postRequest<APIDataModel: Decodable, APIErrorModel: Decodable>(
        url: URL,
        headers: [String: String],
        postParams: [String: Any],
        standardError: APIErrorModel,
        completion: @escaping (Result<APIDataModel, APIErrorModel>) -> Void
    ) {
        let jsonParams = try? JSONSerialization.data(withJSONObject: postParams, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (headerField, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonParams) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(standardError))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(standardError))
                return
            }
            
            guard let data else {
                completion(.failure(standardError))
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(APIDataModel.self, from: data) {
                completion(.success(decodedData))
            } else if let decodedError = try? JSONDecoder().decode(APIErrorModel.self, from: data) {
                completion(.failure(decodedError))
            } else {
                completion(.failure(standardError))
            }
        }
        
        task.resume()
    }
    
    func fetchImageData(from url: URL, completion: @escaping (Data?, URL?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                error == nil,
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(data, response.url)
            }
        }.resume()
    }
}
