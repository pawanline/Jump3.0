//
//  Types.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 14/12/21.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]
public  typealias ResultCallback = (Result<Any, PKError>) -> Void
typealias JSONDictionary = [String:Any]


public struct PKError: Error {
    var errorMessage = "Something went wrong...."
    var errorCode = ""
    
    init(error:NetworkError) {
        errorMessage = error.message()
    }
    
    init(error:Error) {
        errorMessage = error.localizedDescription
    }
    
}


public enum ContentType: String {
    case form = "application/x-www-form-urlencoded"
    case json = "application/json"
    case imagePNG = "application/png"
    case imageJPG = "application/jpeg"
    case file = "application/txt"
    case data = "application/octet-stream"
}
