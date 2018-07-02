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
    private let m_matterDetail:MatterDetailModel?
    init(matterDetail:MatterDetailModel) {
        m_matterDetail = matterDetail
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (m_matterDetail?.response?.posts?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let  num = ShareData.sharedInstance.GetStringCGSize(stringValue: "Sachin Ramesh Tendulkar is a former Indian international cricketer and a former captain of the Indian national team, regarded as one of the greatest batsmen of all time. He is the highest run scorer of all time in International cricket.", font: UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular))
        let stringData = m_matterDetail?.response?.posts![indexPath.row].content ?? ""
        let  num = ShareData.sharedInstance.GetStringCGSize(stringValue: stringData, font: UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular))
        return 285+num.height+15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MatterDetailCell
          let data = m_matterDetail?.response?.posts![indexPath.row]
        cell.SetUpView(postData: data!)
        return cell
    }
    

}
