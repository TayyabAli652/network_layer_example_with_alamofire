//
//  ImageModel.swift
//  Network Layer With Alamofire
//
//  Created by Tayyab Ali on 7/25/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
    var imageId: Int
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        
        case imageId = "char_id"
        case imageUrl = "img"
    }
    
    init (from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageId = try values.decodeIfPresent(Int.self, forKey: .imageId) ?? -1
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }
}
