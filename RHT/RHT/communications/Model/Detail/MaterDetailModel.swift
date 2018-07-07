//
//  MaterDetailModel.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation

class MatterDetailModel:Codable {
        let response: DetailResponse?
        let responseCode, statusCode: Int?
        let statusMessage: String?
        init(json:[String:Any]) {
        response = (json["response"] as? DetailResponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
       }
}
struct DetailResponse: Codable {
    let count: Int?
    let page, pagesize: String?
    let posts: [Post]?
    init(json:[String:Any]) {
        count = json["responseCode"] as? Int ?? 0
        page = json["page"] as? String ?? ""
        pagesize = json["pagesize"] as? String ?? ""
        posts = [(json["posts"] as? Post)!]
    }
}
struct Post:Codable {
    let id, userid, matterid, title: String?
    let content: String?
    let photos:[String]?
    let attachment: [Attachment]?
    let receiverid, user_type, sendername, date_created: String?
    let createddate: String?
    let unreadcommentcount: Int?
    init(json:[String:Any]) {
        unreadcommentcount = json["unreadcommentcount"] as? Int ?? 0
        id = json["id"] as? String ?? ""
        userid = json["userid"] as? String ?? ""
        matterid = json["matterid"] as? String ?? ""
        title = json["title"] as? String ?? ""
        content = json["content"] as? String ?? ""
        photos = json["photos"] as? [String] ?? []
        attachment = [(json["attachment"] as? Attachment)!]
        receiverid = json["receiverid"] as? String ?? ""
        user_type = json["user_type"] as? String ?? ""
        sendername = json["sendername"] as? String ?? ""
        date_created = json["date_created"] as? String ?? ""
        createddate = json["createddate"] as? String ?? ""
    }
    
}
//struct Photos:Codable {
//    let name,url:String?
//    init(json:[String:Any]) {
//        name = json["name"] as? String ?? ""
//        url = json["url"] as? String ?? ""
//    }
//}
struct Attachment:Codable {
    let name,url:String?
    init(json:[String:Any]) {
        name = json["name"] as? String ?? ""
        url = json["url"] as? String ?? ""
    }
}
