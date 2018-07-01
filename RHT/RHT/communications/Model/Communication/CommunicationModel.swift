//
//  CommunicationModel.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class CommunicationModel:Codable {
    
    let response:Communicationresponse
    let responseCode:Int?
    let statusCode:Int?
    let statusMessage:String?
    init(json:[String:Any]) {
        response = (json["response"] as? Communicationresponse)!
        responseCode = json["responseCode"] as? Int ?? 0
        statusCode = json["statusCode"] as? Int ?? 0
        statusMessage = json["statusMessage"] as? String ?? ""
    }
}
struct Communicationresponse:Codable{
    let count:Int?
    let page:String?
    let pagesize:String?
    let matters:[matters]
    init(json:[String:Any]) {
        count = json["count"] as?  Int ?? 0
        page = json["page"] as? String ?? ""
        pagesize = json["pagesize"] as? String ?? ""
        matters = [(json["user"] as? matters)!]
    }
}
struct matters:Codable {
    let id:String?
    let matterid:String?
    let name:String?
    let description:String?
    let customers:[String]?
    let staffs:[String]?
    let date_created:String?
    let createddate:String?
    let unreadcount:Int?
    init(json:[String:Any]) {
        id = json["id"] as? String ?? ""
        matterid = json["matterid"] as? String ?? ""
        name = json["name"] as? String ?? ""
        description = json["description"] as? String ?? ""
        customers = json["customers"] as? [String] ?? []
        staffs = json["staffs"] as? [String] ?? []
        date_created = json["date_created"] as? String ?? ""
        createddate = json["createddate"] as? String ?? ""
        unreadcount = json["createddate"] as? Int ?? 0
    }
    
}
