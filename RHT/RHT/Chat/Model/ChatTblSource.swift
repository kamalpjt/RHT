//
//  ChatTblSource.swift
//  RHT
//
//  Created by vinoth on 15/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatTblSource: NSObject,UITableViewDataSource {

    private let cellIdentifier = "ChatCell"
    public var chatItem = [ChatData]()
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return chatItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let messagetext = chatItem[indexPath.row].chatMessage{
            
            print(messagetext);
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
            let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            
            return estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+30;
        }else{
            print("error")
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ChatCell
        let item = chatItem[indexPath.row]
        cell.BindValue(chatitem: item)
        return cell
        
        
    }
    
    

}
