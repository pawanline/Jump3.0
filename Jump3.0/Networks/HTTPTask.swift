//
//  HTTPTask.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 14/12/21.
//

import Foundation

public enum HTTPTask {
    case request(bodyParamets: Parameters? = [:],urlParamets: Parameters?, additionalHeaders: HTTPHeaders?  = nil)
}
