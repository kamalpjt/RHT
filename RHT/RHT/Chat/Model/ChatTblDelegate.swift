//
//  ChatTblDelegate.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatTblDelegate: NSObject,UITableViewDelegate {

   public var chatItem = [ChatModel]()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(chatItem[indexPath.row].mType == MessageType.text){
            let messagetext = chatItem[indexPath.row].chatMessage!
            print("message"+messagetext);
            
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
            let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            return estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+39;
        }else if(chatItem[indexPath.row].mType == MessageType.multiple){
            let messagetext = chatItem[indexPath.row].textArray.count
            let size = ShareData.sharedInstance.GetchatStringCGSize(stringValue:chatItem[indexPath.row].multipleHeaderText! , font: UIFont.systemFont(ofSize: 14, weight: .semibold), width: Int(ShareData.GetPhoneCurrentScreenWidth() - 100))
            let totalHeight =  44 * messagetext + Int(size.height) + 23
            return CGFloat(totalHeight)
        }else{
            return UIScreen.main.bounds.size.width/2
        }
    }
}
