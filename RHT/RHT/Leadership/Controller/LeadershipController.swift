//
//  LeadershipController.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import SafariServices
class LeadershipController: UIViewController,PageNationDelegate,LeaderShipSelectionDelegate {
    
    @IBOutlet weak var cvCollectionView: UICollectionView!
    var dataSource:LeaderDataSource?
    var m_NewsArray:[Leaderposts] = []
    var m_pageCount:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpCollectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SetUpCollectionView()
    {
        m_pageCount  = m_pageCount + 1
        let params:[String:String] = ["id":UserDetail.Instance.id!,
                                      "userid":UserDetail.Instance.userid!,
                                      "sessionid":"1",
                                      "page": String(m_pageCount),
                                      "pagesize":"8"]
        MatterParsing.instance.getLeaderList(url: "/getleadership",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! LeaderModel
                if((model.response.posts?.count)!>0){
                    self.cvCollectionView.isHidden = false;
                    //self.lblNoRecord.isHidden = true
                    self.dataSource = LeaderDataSource.init(delegate: self,htmlDelgate: self)
                    self.m_NewsArray = self.m_NewsArray +  model.response.posts!
                    self.dataSource?.m_matterPostDetail = self.m_NewsArray
                    self.dataSource?.m_matterTotalCount = model.response.count
                    self.cvCollectionView.dataSource = self.dataSource
                    self.cvCollectionView.delegate = self.dataSource
                    self.cvCollectionView.reloadData()
                }else{
                    self.cvCollectionView.isHidden = true;
                    //self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    func pageNationAction() {
        SetUpCollectionView()
    }
    func GetSelectedRowDetail(pdfUrl: String, indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaderWebViewController") as! LeaderWebViewController
        vc.pdfurl = pdfUrl
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
