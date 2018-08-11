//
//  NewsController.swift
//  RHT
//
//  Created by kamal on 04/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class NewsController: BaseViewController,PageNationDelegate,GetIDDelegate {
   
    
   
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    var dataSource:NewsDataSource?
     var m_NewsArray:[posts] = []
     var m_pageCount:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        m_pageCount = 0
        self.m_NewsArray.removeAll()
        SetUpCollectionView()
    }
    func SetUpCollectionView()
    {
        m_pageCount  = m_pageCount + 1
        let params:[String:String] = ["id":UserDetail.Instance.id!,
                                      "userid":UserDetail.Instance.userid!,
                                      "sessionid":"1",
                                      "page": String(m_pageCount),
                                      "pagesize":"8","ostype":"ios",
                                      "appversion":(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
                                      "devicetype":"mobile",
                                      "osversion":UIDevice.current.systemVersion]
        MatterParsing.instance.getNewsList(url: "/getnews",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! NewsModel
                if((model.response.posts?.count)!>0){
                    self.newsCollectionView.isHidden = false;
                    self.lblNoRecord.isHidden = true
                    self.dataSource = NewsDataSource.init(delegate: self,htmlDelgate: self)
                    self.m_NewsArray = self.m_NewsArray +  model.response.posts!
                    self.dataSource?.m_matterPostDetail = self.m_NewsArray
                   self.dataSource?.m_matterTotalCount = model.response.count
                    self.newsCollectionView.dataSource = self.dataSource
                    self.newsCollectionView.delegate = self.dataSource
                    self.newsCollectionView.reloadData()
                }else{
                     self.newsCollectionView.isHidden = true;
                     self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    func pageNationAction() {
        SetUpCollectionView()
    }
    func GetSelectedRecevierId(receverid: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsWebviewController") as! NewsWebviewController
        vc.m_HtmlString = receverid
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
