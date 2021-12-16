//
//  URLConstant.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 14/12/21.
//

import Foundation
import UIKit

struct APPURL {
    
    
    private struct Domains {
        static let dev: String = "https://newsapi.org/v2"
        static let qa: String = ""
    }
    
    private struct Routes {
        static let devAPI = ""
    }
    
    enum Envionment: Int {
        case dev = 0
        case qa
        
        
        
        static var selectedEnvironment: Envionment = .dev
        
        
        static func selecteRouteUrl(value: Envionment = Envionment.selectedEnvironment) -> String {
            return Routes.devAPI
        }
        
        static func selectedDomainUrl(value: Envionment = Envionment.selectedEnvironment) -> String {
            switch value {
            case .dev:
                return Domains.dev
            case .qa:
                return Domains.qa
            }
        }
        
        static func selectedBaseURL(value: Envionment = Envionment.selectedEnvironment) -> String {
            
            return Envionment.selectedDomainUrl() + Envionment.selecteRouteUrl()
        }
    }
}
