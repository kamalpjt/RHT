//
//  NewsModel.swift
//  RHT
//
//  Created by kamal on 04/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class NewsModel:Codable{
    let response:NewsDetailResponse
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? NewsDetailResponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct NewsDetailResponse: Codable {
    let count: Int?
    let page, pagesize: String?
    let posts: [NewsPost]?
    init(json:[String:Any]) {
        count = json["responseCode"] as? Int ?? 0
        page = json["page"] as? String ?? ""
        pagesize = json["pagesize"] as? String ?? ""
        posts = [(json["Post"] as? NewsPost)!]
    }
}
struct NewsPost:Codable {
    let shortdescription: String?
    let postdate: String?
    let description, id, title: String?
    init(json:[String:Any]) {
        shortdescription = json["shortdescription"] as? String ?? ""
        postdate = json["postdate"] as? String ?? ""
        description = json["description"] as? String ?? ""
        id = json["id"] as? String ?? ""
        title = json["title"] as? String ?? ""
    }
    
}

