//
//  Request.swift
//  NetworkLayer
//
//  Created by Tayyab Ali on 7/22/20.
//  Copyright © 2020 Tayyab Ali. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseCompletionHandler = (Result<Response, Swift.Error>)->Void

class Request<EndPoint: EndPointType>: NetworkRouter {
    
    private var responseCompletionHandler: ResponseCompletionHandler?
    
    func sendAlamofireRequest(_ route: EndPoint) {
        
        let method = Alamofire.HTTPMethod(rawValue: route.httpMethod.rawValue)
        let headers = Alamofire.HTTPHeaders(route.headers ?? [:])
        let parameters = buildParams(task: route.task)
        let request = AF.request(route.baseURL.appendingPathComponent(route.path), method: method, parameters: parameters.0, encoding: parameters.1, headers: headers)
         
        request.responseJSON { response in
            self.responseConfiguration(response)
        }
    }
    
    private func responseConfiguration(_ response: AFDataResponse<Any>) {
        debugPrint("Response: \(response)")
        //                NetworkLogger.log(request: response.request!)
        
        guard let statusCode = response.response?.statusCode else {
            print("StatusCode not found")
            let error = NSError(domain:"Status code is invalid", code:0, userInfo:nil)
            self.responseCompletionHandler?(.failure(error))
            return
        }
        
        guard let data = response.data else {
            let error = NSError(domain:"Invalid Content From Server", code:0, userInfo:nil)
            self.responseCompletionHandler?(.failure(error))
            return
        }
        let response = Response(statusCode: statusCode, data: data, request: response.request, response: response.response)
        
        self.responseCompletionHandler?(.success(response))
    }
    
    func uploadMultipart(_ route: EndPoint, multipartFormData: MultipartFormData) {
        
        let method = Alamofire.HTTPMethod(rawValue: route.httpMethod.rawValue)
        let headers = Alamofire.HTTPHeaders(route.headers ?? [:])
        let request = AF.upload(multipartFormData: multipartFormData, to: route.baseURL.appendingPathComponent(route.path), method: method, headers: headers)
            .uploadProgress(queue: .main) { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
        }
        request.responseJSON { response in
            self.responseConfiguration(response)
        }
    }
    
    func request(_ route: EndPoint, completion: @escaping ResponseCompletionHandler) {
        responseCompletionHandler = completion
        
        switch route.task {
        case .uploadMultipart(let multipartFormData):
            uploadMultipart(route, multipartFormData: multipartFormData)
        default:
            
            self.sendAlamofireRequest(route)
            break
        }
    }
    
    private func buildParams(task: HTTPTask) -> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        default:
            return ([:], URLEncoding.default)
        }
    }
}
