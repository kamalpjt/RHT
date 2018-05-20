//
//  MaterDetailModel.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation

class MatterDetailModel {
    
    var username:String?
    var subject:String?
    var description:String?
    var imageUrl:String?
    var filename:String?
    var CommentTotalcount:Int?
    var date:String?
    init(username:String,subject:String,description:String,imageUrl:String,filename:String,CommentTotalcount:Int,date:String) {
        self.username = username
        self.subject = subject
        self.imageUrl = imageUrl;
        self.filename = filename
        self.CommentTotalcount = CommentTotalcount
        self.date = date
    }
    
}
