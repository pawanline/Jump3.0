//
//  APIError.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 14/12/21.
//

import Foundation
import UIKit

enum NetworkError: Error, Equatable {
    case missingURL
    case encoding
    case decoding
    case authentication
    case badRequest
    case outdated
    case failed
    case server(message: String)
    case authorizationFail
    
     func message() -> String {
           switch self {
           case .missingURL:
               return ""
           case .encoding:
               return ""
           case .decoding:
               return ""
           case .authentication:
               return ""
           case .badRequest:
               return ""
           case .outdated:
               return ""
           case .failed:
               return ""
           case .server(let message):
               return message
           case .authorizationFail:
                return ""
           }
       }
}
