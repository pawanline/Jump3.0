//
//  LoginRequest.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 15/12/21.
//

import Foundation

enum LoginRequest {
    case getUserSetting(params: Parameters)
}


extension LoginRequest: Request {
    
    var path: String {
        return "sdfasdfsf"
    }
    
    var httpMethod: HTTPMethod {
        .post
    }
    
    var task: HTTPTask {
        switch self {
        case .getUserSetting(let params):
            return .request(bodyParamets: nil, urlParamets: params, additionalHeaders: nil)

        }
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var contentType: ContentType {
        .json
    }
    
    
}
