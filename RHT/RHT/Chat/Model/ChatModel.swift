//
//  ChatModel.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation

class ChatModel{
    
    var chatMessage:String?
    var userName:String?
    var IsSender:Bool?
    var date:String?
    var mType:MessageType
    var imageUrl:String?
    var textArray:[[String : AnyObject]]
    init(chatMessage:String,userName:String,IsSender:Bool,date:String,imageUrl:String,mType:MessageType,mtextArray:[[String : AnyObject]]) {
        self.chatMessage = chatMessage
        self.userName = userName
        self.IsSender = IsSender
        self.date = date;
        self.mType = mType
        self.imageUrl = imageUrl
        self.textArray = mtextArray
    }
}
