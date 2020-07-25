//
//  Response.swift
//  NetworkLayer
//
//  Created by Tayyab Ali on 7/22/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation

class Response: CustomDebugStringConvertible, Equatable {
    public let statusCode: Int
    
    /// The response data.
    public let data: Data
    
    /// The original URLRequest for the response.
    public let request: URLRequest?
    
    /// The HTTPURLResponse object.
    public let response: HTTPURLResponse?
    
    public init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    
    /// A text description of the `Response`.
    public var description: String {
        return "Status Code: \(statusCode), Data Length: \(data.count)"
    }
    
    /// A text description of the `Response`. Suitable for debugging.
    public var debugDescription: String {
        return description
    }
    
    public static func == (lhs: Response, rhs: Response) -> Bool {
        return lhs.statusCode == rhs.statusCode
            && lhs.data == rhs.data
            && lhs.response == rhs.response
    }
    
    func makeJson() throws -> Any {
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            let error = NSError(domain:"Invalid Content From Server", code:0, userInfo:nil)
            throw error
        }
    }
}
