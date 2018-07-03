//
//  MatterDetailDataSource.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterDetailDataSource: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private let cellIdentifier = "MatterDetailCell"
    public var m_matterPostDetail:[Post]?
    public var m_matterTotalCount:Int?
//    init(matterDetail:MatterDetailModel) {
//        m_matterDetail = matterDetail
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (m_matterPostDetail?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let stringData = m_matterPostDetail?[indexPath.row].content ?? ""
        let  num = ShareData.sharedInstance.GetCommunicationStringCGSize(stringValue: stringData, font: UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular))
        return 285+num.height+15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MatterDetailCell
        let data = m_matterPostDetail?[indexPath.row]
        cell.SetUpView(postData: data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(m_matterTotalCount != m_matterPostDetail?.count)
        {
            if((m_matterPostDetail?.count)! - 1 == indexPath.row)
            {
                print("Last row called")
            }
        }
        
    }
    

}
