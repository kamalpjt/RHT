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
    var RHTDDevIp:String?
     var RHTProdIp:String?
    var AWSSID:String?
    
    func setEnviroment(eBuildEnvironments:eBuildEnvironment) -> Void{
        
        switch eBuildEnvironments {
        case eBuildEnvironment.eDev:
            //dialogflowApi = "93feb2646fd54d58ab567ba596761d6d"
            dialogflowApi = "dbebe1829e3247c386cd5ab1f41e09ff"
            RHTDDevIp = "http://54.254.224.249:3020"
            AWSSID = "ap-southeast-1:a21d3232-dbcf-4b32-81e0-04c3b70cca93"
            break
            
        default:
            dialogflowApi = "http://54.255.184.158:3010/l"
            RHTProdIp = "http://54.254.224.249:3010"
            break
            
        }
    }
}
