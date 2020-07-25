//
//  NetworkApis.swift
//  Network Layer With Alamofire
//
//  Created by Tayyab Ali on 7/25/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import UIKit
import Alamofire

enum APIEviroment {
    case production
    case development
}

//actual API endpoints
enum NetworkAPI {
    
    case fetchData
}

//end end points
extension NetworkAPI : EndPointType {
    
    fileprivate var enviromentBaseURL: String{
        
        switch NetworkManager.enviroment {
        case .development: return "https://www.breakingbadapi.com/api/"
        case .production: return "https://www.breakingbadapi.com/api/"
        }
    }
    
    var baseURL: URL{
        
        guard let url  = URL(string: enviromentBaseURL) else { fatalError("baseURL couldnt be configured!") }
        return url
    }
    
    var path: String {
        
        switch self {
            
        case .fetchData:
            return "characters"
        }
    }
    
    var httpMethod: HTTPMethod{
        
        switch self {
        case .fetchData:
            return .get
        }
    }
    
    var task: HTTPTask {
                
        switch self {
        case .fetchData:
            return .requestParameters(parameters: ["limit": 2], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data{
        return Data()
    }
    
    var headers: [String : String]?{
        let assigned: [String: String] = [
            "Accept": "application/json",
            "Accept-Language": "",
            "Content-Type": "application/json",
        ]
        
        return assigned
    }
}
