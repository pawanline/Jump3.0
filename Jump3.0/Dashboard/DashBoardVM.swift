//
//  DashBoardVM.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 16/12/21.
//

import Foundation

class DashBoardVM {
    
    // MARK: - Properties
    // MARK: -
    let dashboardService = DashboardService()
    
    func getNewsHeadelines() {
        var params = JSONDictionary()
        params["country"] = "us"
        params["apiKey"] = "55c23c9f979d46e5bade55a65afca43b"
        dashboardService.getNewsHeadelines(params: params) { dataDict, error in
            print(dataDict)
        }
    }
}
