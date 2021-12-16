//
//  DashboardService.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 16/12/21.
//

import Foundation

class DashboardService {
    let client = APIClient<DashboardRequest>()

    
    func getNewsHeadelines(params: JSONDictionary, responseHandler: @escaping ((JSONDictionary, PKError?) -> Void) ) {
        client.send(.getNewsHeadelines(params: params)) { (result) in
            switch result {
            case .success(let response):
                guard let responseObj = response as? JSONDictionary,
                      let _ = responseObj["result"] as? JSONDictionary else {
                        responseHandler(JSONDictionary(), nil)
                        return
                }
                guard let status_code = responseObj["status_code"] as? Int, status_code == 200 else {
                    responseHandler(JSONDictionary(),nil)
                    return
                }
               
                    responseHandler(JSONDictionary(), nil)
            case .failure(let error):
                responseHandler(JSONDictionary(), error)
            }
        }
    }
}
