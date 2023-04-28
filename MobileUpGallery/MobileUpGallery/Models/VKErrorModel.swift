//
//  VKErrorModel.swift
//  MobileUpGallery
//
//  Created by Pavlentiy on 28.04.2023.
//

import Foundation

struct VKErrorModel: Error {
    let errorCode: Int?
    let errorMSG: String?
    let errorText: String?
}
