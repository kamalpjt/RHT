//
//  UserDetail.swift
//  RHT
//
//  Created by kamal on 13/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation

class UserDetail {
    static let Instance = UserDetail()
    var isStaff:Int? = 0
    var email:String? = ""
    var phone:String? = ""
    var name:String? = ""
    var password:String? = ""
    var user_type:String? = ""
    var userid:String? = ""
    var id:String? = ""
}

// static let Instance = UserDetail(isStaff: Int, email: String, phone: String, name: String, password: String, user_type: String, userid: String, id: String)

