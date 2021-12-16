//
//  APIClient.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 15/12/21.
//

import Foundation

protocol NetworkClient: class {
    associatedtype APIRequest = Request
    
    func send(_ request: APIRequest, completion: @escaping ResultCallback)
        
    
}

class APIClient<APIRequest: Request>: NetworkClient {
    
    var session = URLSession(configuration: .default)
    
    func send(_ request: APIRequest, completion: @escaping ResultCallback) {
            execute(request, completion: completion)
        }
    
    private func execute(_ request: APIRequest, completion: @escaping ResultCallback) {
        do {
            let req: URLRequest = try request.build()
            print(req.url?.absoluteString ?? "")
            // TODO:- Enabled Session pining
                let config = URLSessionConfiguration.default
    
                self.session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
            //Enable Pinning code end
            
            let task = session.dataTask(with: req) { data, response, error in
                if let data = data {
                    do {
                        
                    print("Web service URL \(req.url?.absoluteString ?? "") \nHTTP HEADERS \(req.allHTTPHeaderFields.debugDescription) \nParams  \(String(decoding: req.httpBody ?? Data(), as: UTF8.self)) \nResponse in Real JSON" + String(decoding: data, as: UTF8.self))
                        
                        
                        // Decode the top level response, and look up the decoded response to see
                        // if it's a success or a failure
                        if let httpResponse = response as? HTTPURLResponse {
                            let result = self.handleNetworkResponse(response: httpResponse)
                            switch result {
                            case .success:
                                let responseObject = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0))
                                print(responseObject)
                                DispatchQueue.main.async {
                                    completion(.success(responseObject))
                                }
                           
                            case .failure(let httpError):
                                DispatchQueue.main.async {
                                    let error = PKError(error: httpError)
                                    completion(.failure(error))
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            let error = PKError(error: error)
                            completion(.failure(error))
                        }
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        let error = PKError(error: error)
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        } catch {
            DispatchQueue.main.async {
                let exception = PKError(error: error)
                completion(.failure(exception))
            }
        }
    }
    
    
    func cancel() {
        //        self.task?.cancel()
    }
    
    /// Default handler for HTTP response codes.
    func handleNetworkResponse(response: HTTPURLResponse) -> Result<String, NetworkError> {
        
        switch response.statusCode {
        case 200...209:
            return .success("Ok")
        case 400...499:
            if response.statusCode == 401 {
                return .failure(NetworkError.authorizationFail)
            }
            return .failure(NetworkError.authentication)
        case 500...599:
            return .failure(NetworkError.badRequest)
        case 600:
            return .failure(NetworkError.outdated)
        default:
            return .failure(NetworkError.failed)
        }
    }
}

