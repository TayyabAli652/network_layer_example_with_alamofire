//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by Tayyab Ali on 7/22/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping (Result<Response, Swift.Error>)-> Void)
}
