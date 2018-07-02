//
//  ClientModel.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class ClientModel:Codable {
    
    let response:clientresponse
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? clientresponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct clientresponse:Codable{
    let count:Int?
    let userlist:[Userlist]
    init(json:[String:Any]) {
        userlist = [(json["user"] as? Userlist)!]
        count = json["count"] as? Int ?? 0
    }
}
struct Userlist:Codable {
    let user_type:String?
    let phone:String?
    let last_name:String?
    let id:String?
    let first_name:String?
    let userid:String?
    let email:String?
    let unreadcount:Int?
    let name:String?
    init(json:[String:Any]) {
        user_type = json["user_type"] as? String ?? ""
        phone = json["phone"] as? String ?? ""
        last_name = json["last_name"] as? String ?? ""
        id = json["id"] as? String ?? ""
        first_name = json["first_name"] as? String ?? ""
        userid = json["userid"] as? String ?? ""
        email = json["email"] as? String ?? ""
        unreadcount = json["unreadcount"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        
    }
}
