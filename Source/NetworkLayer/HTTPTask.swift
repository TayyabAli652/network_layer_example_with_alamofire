//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Tayyab Ali on 7/22/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPTask {
    
    case requestPlain
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
    case uploadMultipart(_ : MultipartFormData)
}
