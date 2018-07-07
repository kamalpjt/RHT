//
//  CommunicationDetailController.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit



class CommunicationDetailController: UIViewController,UITableViewDelegate,PageNationDelegate {
   
    
    
    @IBOutlet weak var lblNoRecordFound: UILabel!
    
    @IBOutlet weak var tblmatterDetail: UITableView!
    private let cellIdentifier = "MatterCell"
    // var cell:MatterDetailCell?
    var dataSource:MatterDetailDataSource?
    var dataDelegate:MasterDetailDelegate?
    var m_matterType:String = "";
    var m_receverid:String = "";
    var m_matterid:String = "";
    var m_pageCount:Int = 0
    var m_matterArray:[Post] = []
    //MARK:- ViewcontrollerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        //tblmatterDetail.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0);
        configureTableView()
        navigationItem.rightBarButtonItems = [plusButton()]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.CommentAction(notification:)), name: Notification.Name("CommentAction"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.CommentListAction(notification:)), name: Notification.Name(AppConstant.sharedInstance.commentListAction), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CommentAction"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(AppConstant.sharedInstance.commentListAction), object: nil)
    }
    //MARK:Common Funcation
    func configureTableView() -> Void{
        tblmatterDetail.separatorStyle = .none
        //tblmatterDetail.estimatedRowHeight = 150;
        m_pageCount  = m_pageCount + 1
        let params:[String:String] = ["id":UserDetail.Instance.id!,
                                      "userid":UserDetail.Instance.userid!,
                                      "sessionid":"1",
                                      "page":String(m_pageCount),
                                      "pagesize":"5",
                                      "user_type":UserDetail.Instance.user_type!,
                                      "posttype":m_matterType,
                                      "receiverid":m_receverid,
                                      "matterid": m_matterid]
        MatterParsing.instance.getCommunicationDetailList(url: "/getcommunication", param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! MatterDetailModel
                if((model.response?.posts?.count)!>0){
                    self.tblmatterDetail.isHidden = false;
                    self.lblNoRecordFound.isHidden = true;
                    
                    self.dataSource = MatterDetailDataSource.init(delegate: self,tableViews: self.tblmatterDetail)
                    self.m_matterArray.append(contentsOf: (model.response?.posts)!)
                    self.dataSource?.m_matterPostDetail = self.m_matterArray
                    self.dataSource?.m_matterTotalCount = model.response?.count
                    self.dataDelegate = MasterDetailDelegate()
                    
                    self.tblmatterDetail.dataSource = self.dataSource
                    self.tblmatterDetail.delegate = self.dataSource
                    self.tblmatterDetail.reloadData()
                    
                }else{
                    self.tblmatterDetail.isHidden = true;
                    self.lblNoRecordFound.isHidden = false;

                }
            }
        })
        
    }
    //MARK:Common Funcation
    func configureTableViewPageNation() -> Void{
        tblmatterDetail.separatorStyle = .none
        //tblmatterDetail.estimatedRowHeight = 150;
        m_pageCount  = m_pageCount + 1
        let params:[String:String] = ["id":UserDetail.Instance.id!,
                                      "userid":UserDetail.Instance.userid!,
                                      "sessionid":"1",
                                      "page":String(m_pageCount),
                                      "pagesize":"5",
                                      "user_type":UserDetail.Instance.user_type!,
                                      "posttype":m_matterType,
                                      "receiverid":m_receverid,
                                      "matterid": m_matterid]
        MatterParsing.instance.getCommunicationDetailList(url: "/getcommunication", param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! MatterDetailModel
                if((model.response?.posts?.count)!>0){
                    self.tblmatterDetail.isHidden = false;
                    self.lblNoRecordFound.isHidden = true;
                    
                  //  self.dataSource = MatterDetailDataSource.init(delegate: self)
                    self.m_matterArray.append(contentsOf: (model.response?.posts)!)
                    self.dataSource?.m_matterPostDetail = self.m_matterArray
                    self.dataSource?.m_matterTotalCount = model.response?.count
                    self.dataDelegate = MasterDetailDelegate()
                    
                   // self.tblmatterDetail.dataSource = self.dataSource
                   // self.tblmatterDetail.delegate = self.dataSource
                    self.tblmatterDetail.reloadData()
                    
                }else{
                    self.tblmatterDetail.isHidden = true;
                    self.lblNoRecordFound.isHidden = false;
                    
                }
            }
        })
        
    }

    func pageNationAction() {
       // configureTableView()
        configureTableViewPageNation()
    }
    func GetPhotoArray(index: NSArray) {
        
    }
    func SetUpCollectionView()
    {
        
    }
    func plusButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setImage(UIImage.init(named: "PluseWhite"), for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(AddButton), for: UIControlEvents.touchUpInside)
        // menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        // menuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        //menuButton.contentMode = UIViewContentMode.right
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    //MARK:Action
    @objc func AddButton() -> Void{
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"AddCommunicationController") as! AddCommunicationController
        vc.matterType = m_matterType
        vc.recevierId = m_receverid
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func CommentAction(notification: Notification){
       // let imgd  = notification.userInfo;
        //let dfdf =  (UIButton)imgd!["Sender"]
         let image = notification.userInfo?["Sender"] as? UIButton
        let arrayphoto = self.m_matterArray[(image?.tag)!].photos;
        let VC = ImageListController()
         VC.m_PhotosArray = arrayphoto
        navigationController?.pushViewController(VC, animated: true)
        
    }
    @objc func CommentListAction(notification: Notification){
        let image = notification.userInfo?["Sender"] as? UIButton
        let arrayid = self.m_matterArray[(image?.tag)!].id;
        let VC = ChatListController()
        VC.m_postId = arrayid!
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
