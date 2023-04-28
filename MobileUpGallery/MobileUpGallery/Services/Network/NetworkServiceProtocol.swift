//
//  NetworkServiceProtocol.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 25.04.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func postRequest<APIDataModel: Decodable, APIErrorModel: Decodable>(
        url: URL,
        headers: [String: String],
        postParams: [String: Any],
        standardError: APIErrorModel,
        completion: @escaping (Result<APIDataModel, APIErrorModel>) -> Void
    )
    func fetchImageData(from url: URL, completion: @escaping (Data?, URL?) -> Void)
}
