//
//  CommentPostModel.swift
//  RHT
//
//  Created by kamal on 08/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class CommentPostModel: Codable {
    let response:Message
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? Message)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
class Message: Codable {
    let msg:String?
     init(json:[String:Any]) {
        msg = json["msg"] as? String ?? ""
    }
}
