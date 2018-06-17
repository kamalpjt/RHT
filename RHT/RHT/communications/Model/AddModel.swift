//
//  AddModel.swift
//  RHT
//
//  Created by kamal on 15/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation

struct AddModel:Codable {
    let response:response1
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? response1)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct response1:Codable {
    let msg:String?
    init(json:[String:Any]) {
        msg = json["msg"] as? String ?? ""
    }
}
