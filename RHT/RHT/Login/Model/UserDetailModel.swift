//
//  UserDetailModel.swift
//  RHT
//
//  Created by kamal on 04/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
struct UserDetailModel:Decodable {
    let isStaff:Int?
    let user:[user]
//    init(json:[String:Any]) {
//        isStaff = json["isStaff"] as? Int ?? 0
//        user = json["user"] as! user
//    }
    
}
struct  user:Decodable {
    
    let email:String?
    let phone:String?
    let name:String?
    let password:String?
    let user_type:String?
    let userid:String?
    let id:String?
//    init(json:[String:Any]) {
//        email = json["email"] as? String ?? ""
//        phone = json["phone"] as? String ?? ""
//        name = json["name"] as? String ?? ""
//        password = json["password"] as? String ?? ""
//        user_type = json["user_type"] as? String ?? ""
//        userid = json["userid"] as? String ?? ""
//        id = json["id"] as? String ?? ""
//    }
}
