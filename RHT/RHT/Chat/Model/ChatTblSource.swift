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
    private let cellIdentifierimage = "imagecell"
      private let cellIdentifiertable = "tableCell"
    public var chatItem = [ChatModel]()
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return chatItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(chatItem[indexPath.row].mType == MessageType.text){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ChatCell
            let item = chatItem[indexPath.row]
            cell.BindValue(chatitem: item)
            return cell
        }else if (chatItem[indexPath.row].mType == MessageType.multiple){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiertable) as! tableCell
            let item = chatItem[indexPath.row]
            cell.BindValue(chatitem: item)
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierimage) as! ImageChatcell
            let item = chatItem[indexPath.row]
            cell.BindValue(item: item)
            return cell
        }
       
        
        
    }
    
    

}
