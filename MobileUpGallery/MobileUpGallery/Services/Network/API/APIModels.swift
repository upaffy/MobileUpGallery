//
//  APIModels.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 27.04.2023.
//

import Foundation

struct ErrorAPIContainer: Decodable, Error {
    struct ErrorAPIModel: Decodable {
        enum CodingKeys: String, CodingKey {
            case errorCode = "error_code"
            case errorMSG = "error_msg"
            case errorText = "error_text"
        }
        
        let errorCode: Int?
        let errorMSG: String?
        let errorText: String?
    }
    
    let error: ErrorAPIModel?
}

struct PhotosListApiModel: Decodable {
    enum SizeType: String, Decodable {
        case s, m, x, o, p, q, r, y, z, w
    }
    
    struct SizeAPIModel: Decodable {
        let type: SizeType?
        let url: URL?
    }

    struct PhotoAPIModel: Decodable {
        let id: Int?
        let date: Double?
        let sizes: [SizeAPIModel]?
    }
    
    let photos: [PhotoAPIModel]?
}

extension PhotosListApiModel {
    enum CodingKeys: String, CodingKey {
        case photos = "response"
        enum ItemsKeys: String, CodingKey {
            case items
        }
    }
    
    init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self)
        let itemsContainer = try responseContainer.nestedContainer(
            keyedBy: CodingKeys.ItemsKeys.self,
            forKey: .photos
        )
        
        photos = try itemsContainer.decode([PhotoAPIModel].self, forKey: .items)
    }
}
