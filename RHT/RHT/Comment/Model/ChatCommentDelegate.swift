//
//  ChatTblDelegate.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatCommentDelegate: NSObject,UITableViewDelegate {

   public var chatItem = [CommetList]()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //if(chatItem[indexPath.row].mType == MessageType.text){
            let messagetext = chatItem[indexPath.row].comment!
            print("message"+messagetext);
            
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].sendername!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
            let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].createddate!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            return estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+39;
       // }else{
            return UIScreen.main.bounds.size.width/2
        //}
    }
}
