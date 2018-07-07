//
//  CommentListModel.swift
//  RHT
//
//  Created by kamal on 07/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class CommentListModel: Codable {
    
    let response:CommentsResponse
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? CommentsResponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct CommentsResponse:Codable {
    let count: Int?
    let page, pagesize: String?
    let comments: [CommetList]?
    init(json:[String:Any]) {
        count = json["count"] as? Int ?? 0
        page = json["page"] as? String ?? ""
        pagesize = json["pagesize"] as? String ?? ""
        comments =  [(json["comments"] as? CommetList)!]
    }
}
struct CommetList:Codable {
    let id, userid, postid, comment: String?
    let userType, sendername, dateCreated, createddate: String?
    init(json:[String:Any]) {
         id = json["id"] as? String ?? ""
         userid = json["userid"] as? String ?? ""
         postid = json["postid"] as? String ?? ""
         comment = json["comment"] as? String ?? ""
         userType = json["userType"] as? String ?? ""
         sendername = json["sendername"] as? String ?? ""
         dateCreated = json["dateCreated"] as? String ?? ""
         createddate = json["createddate"] as? String ?? ""
    }
}
