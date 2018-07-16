//
//  ChatTblSource.swift
//  RHT
//
//  Created by vinoth on 15/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
protocol DeleteCommentdelegate {
    func DeleteComment(indexPath:IndexPath)
}
class CommentTblSource: NSObject,UITableViewDataSource {

    private let cellIdentifier = "CommentCell"
    private let cellIdentifierimage = "imagecell"
    public var chatItem = [CommetList]()
    public var m_TotalCount:Int?
    var m_delegate:DeleteCommentdelegate?
    init(delegate:DeleteCommentdelegate) {
        m_delegate = delegate
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return chatItem.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            //m_pageNationDelgate?.DeleteTableRow!(indexPath: indexPath)
            m_delegate?.DeleteComment(indexPath: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if(chatItem[indexPath.row].mType == MessageType.text){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CommentCell
            let item = chatItem[indexPath.row]
            cell.BindValue(chatitem: item)
            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierimage) as! ImageChatcell
//            let item = chatItem[indexPath.row]
//            cell.BindValue(item: item)
//            return cell
//        }
    }
    
    

}
