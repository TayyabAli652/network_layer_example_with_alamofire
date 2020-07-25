//
//  EndPointType.swift
//  NetworkLayer
//
//  Created by Tayyab Ali on 7/22/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: [String : String]? { get }
}
