//
//  ActivateModel.swift
//  RHT
//
//  Created by kamal on 12/08/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class ActivateModel: Codable {
    let response:ActivateMessage
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? ActivateMessage)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
class ActivateMessage: Codable {
    let sentotp:Int?
    let phone:String?
    let id:String?
    
    init(json:[String:Any]) {
        sentotp = json["sentotp"] as? Int ?? 0
        phone = json["phone"] as? String ?? ""
        id = json["id"] as? String ?? ""
    }
}
