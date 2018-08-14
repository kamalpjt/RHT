//
//  VerifyOTPModel.swift
//  RHT
//
//  Created by kamal on 12/08/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class VerifyOTPModel: Codable {
    let response:VerifyOTPMessage
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? VerifyOTPMessage)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
class VerifyOTPMessage: Codable {
    let verifysucess:Int?
    let userid:String?
    let id:String?
    let error:String?
    
    init(json:[String:Any]) {
        verifysucess = json["verifysucess"] as? Int ?? 0
        userid = json["userid"] as? String ?? ""
        id = json["id"] as? String ?? ""
        error = json["error"] as? String ?? ""
    }
}
