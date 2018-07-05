//
//  LeaderModel.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class LeaderModel: Codable {
    let response:LeaderDetailResponse
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? LeaderDetailResponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct LeaderDetailResponse: Codable {
    let count: Int?
    let page, pagesize: String?
    let posts: [Leaderposts]?
    init(json:[String:Any]) {
        count = json["count"] as? Int ?? 0
        page = json["page"] as? String ?? ""
        pagesize = json["pagesize"] as? String ?? ""
        posts =  [(json["posts"] as? Leaderposts)!]
    }
}
struct Leaderposts:Codable {
    let imageurl: String?
    let description, id, title ,pdfurl: String?
    init(json:[String:Any]) {
        imageurl = json["imageurl"] as? String ?? ""
        description = json["description"] as? String ?? ""
        pdfurl = json["pdfurl"] as? String ?? ""
        id = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
    }
    
}
