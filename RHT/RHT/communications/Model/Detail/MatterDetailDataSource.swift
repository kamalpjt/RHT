//
//  MatterDetailDataSource.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

@objc protocol PageNationDelegate {
    func pageNationAction()
    @objc optional func GetPhotoArray(index:NSArray)
    @objc optional func DeleteTableRow(indexPath:IndexPath)
}

class MatterDetailDataSource: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private let cellIdentifier = "MatterDetailCell"
    public var m_matterPostDetail:[Post]?
    public var m_matterTotalCount:Int?
    var m_tableView:UITableView?
    let m_pageNationDelgate:PageNationDelegate?
    init(delegate:PageNationDelegate,tableViews:UITableView) {
        m_pageNationDelgate = delegate
        m_tableView = tableViews;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(m_matterPostDetail != nil)
        {
            return (m_matterPostDetail?.count)!
        }else{
            return 0 ;
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let stringData = m_matterPostDetail?[indexPath.row].content ?? ""
        let  num = ShareData.sharedInstance.GetCommunicationStringCGSize(stringValue: stringData, font: UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular))
        return 285+num.height+15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MatterDetailCell
        cell.butMoreButton.tag = indexPath.row
        cell.butComment.tag = indexPath.row
        let data = m_matterPostDetail?[indexPath.row]
        cell.SetUpView(postData: data!)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            m_pageNationDelgate?.DeleteTableRow!(indexPath: indexPath)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var getLastRow =  m_tableView?.indexPathsForVisibleRows?.last
        if(getLastRow?.row == ((m_matterPostDetail?.count)! - 1) && (m_matterPostDetail?.count)! < m_matterTotalCount!)
        {
            print("Called" + String((getLastRow?.row)! + 1))
          //  print(m_matterTotalCount)
           // print(m_matterPostDetail?.count)
            m_pageNationDelgate?.pageNationAction()
        }
    }
    
    
}
