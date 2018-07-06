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
    
}

class MatterDetailDataSource: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private let cellIdentifier = "MatterDetailCell"
    public var m_matterPostDetail:[Post]?
    public var m_matterTotalCount:Int?
    let m_pageNationDelgate:PageNationDelegate?
    init(delegate:PageNationDelegate) {
        m_pageNationDelgate = delegate
    }
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
        cell.butMoreButton.tag = indexPath.row
        cell.butComment.tag = indexPath.row
        let data = m_matterPostDetail?[indexPath.row]
        cell.SetUpView(postData: data!)
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.y
       // print(scrollView.contentOffset.y)
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            if(m_matterTotalCount != m_matterPostDetail?.count)
            {
                  print("Last row called")
                m_pageNationDelgate?.pageNationAction()
            }else{
                 print("Last row completed")
            }
        }
    }
    

}
