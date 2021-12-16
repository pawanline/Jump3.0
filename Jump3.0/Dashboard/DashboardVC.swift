//
//  DashboardVC.swift
//  Jump3.0
//
//  Created by Pawan Kumar on 16/12/21.
//

import Foundation
import UIKit

class DashboardVC: UIViewController {
    
    let viewModel = DashBoardVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.getNewsHeadelines()
    }
    
    
    
}
