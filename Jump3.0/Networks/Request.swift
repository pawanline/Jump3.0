//
//  Request.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 14/12/21.
//

import Foundation

let TIMEOUT_INTERVAL: TimeInterval = 1800

public protocol Request {
    associatedtype Response = Any
    
    var baseURL: URL? { get }
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    
    var headers: HTTPHeaders { get }
    
    var contentType: ContentType { get }
    
    func build() throws -> URLRequest
    
}


extension Request {
    var baseURL: URL? {
        return URL(string: APPURL.Envionment.selectedBaseURL())
    }
    
    var commonHeaders: HTTPHeaders {
        return [:]
    }
    
    func build() throws -> URLRequest {
        guard let baseURL = baseURL else {
            throw NetworkError.missingURL
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(self.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TIMEOUT_INTERVAL)
        if path.isEmpty {
            request = URLRequest(url: baseURL.appendingPathComponent(self.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TIMEOUT_INTERVAL)
        }
        
        request.httpMethod = self.httpMethod.rawValue
        
        
        addAdditionalHeaders(headers: headers, request: &request)
        
        do {
            switch task {
            case .request(var bodyParameters,let urlParameters,let _):
              try  configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
        } catch {
            throw error
        }
        
        return request

    }
    
    
    private func addAdditionalHeaders(headers: HTTPHeaders?, request: inout URLRequest ) {
        guard let headers = headers else {
            return
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
    private func setContentType(urlRequest: inout URLRequest) {
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
    
    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            print("body Parameter: \(bodyParameters ?? [:])")
            if let bodyParameters = bodyParameters, bodyParameters.count > 0 {
                if contentType == .json {
                    print("request URL \(request)")
                    try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
                } else {
                    try FormParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
                }
            }
            if let urlParameters = urlParameters ,urlParameters.count > 0 {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    
}
