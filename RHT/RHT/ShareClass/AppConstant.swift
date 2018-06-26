//
//  AppConstant.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import UIKit
class AppConstant  {
    
    static let sharedInstance = AppConstant()
    //Response code
   let INTERNALSUCESSCODE = 1000
    //BucketName
    let IMAGEBUCKETNAME = "rhtapp"
    let PDFEBUCKETNAME  = "rhtapp-pdf"
    let CONTENTTYPEIMAGE = "image/jpeg"
    //Chat constanct
    var chatItem = [ChatModel]()
    var userDetails = UserDetail.self
    //static var appConstant = AppConstant()
    let gooleplusid = "419503471544-0d4f7g754k1nol46catr24u90sjgrq4b.apps.googleusercontent.com"
    let backGroundColor = UIColor.init(red: 223/255.0, green: 52/255.0, blue: 71/255.0, alpha: 1.0)
    let borderChat = UIColor.init(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.3)
    let textline = UIColor.init(red: 218/255.0, green: 219/255.0, blue: 220/255.0, alpha: 1.0)
    let viewEmailBoder = UIColor.init(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha: 1.0)
    let SAVELOGINDETAIL = "save"
    //MARK:-POST Notfication
    let commentListAction = "commentListAction"
    let SELECTEDINDEXPATH = "selectedindexpath"
    
    
}
