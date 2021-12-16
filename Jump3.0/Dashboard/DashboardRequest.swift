//
//  DashboardRequest.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 16/12/21.
//

import Foundation

enum DashboardRequest {
    case getNewsHeadelines(params: Parameters)
}

extension DashboardRequest: Request {
    var contentType: ContentType {
        .json
    }
    
    var path: String {
        switch self {
        case .getNewsHeadelines:
            return "top-headlines"
        }
    }
    

    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getNewsHeadelines(let params):
            return .request(bodyParamets: [:], urlParamets: params)
       
        }
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
}
