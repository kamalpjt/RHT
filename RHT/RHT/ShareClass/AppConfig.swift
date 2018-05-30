//
//  AppConfig.swift
//  RHT
//
//  Created by kamal on 5/30/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
 
class AppConfig {
    
    static let sharedInstance = AppConfig()
    var dialogflowApi:String?
    
    func setEnviroment(eBuildEnvironments:eBuildEnvironment) -> Void{
        
        switch eBuildEnvironments {
        case eBuildEnvironment.eDev:
            dialogflowApi = "93feb2646fd54d58ab567ba596761d6d"
            break
            
        default:
            dialogflowApi = ""
            break
            
        }
    }
}
