//
//  CommunicationDetailController.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit



class CommunicationDetailController: UIViewController,UITableViewDelegate,PageNationDelegate,UpdateApiDelegate {
   
    
    
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
    var m_deleteCount:Int = 0
    var m_matterArray:[Post] = []
    var m_FromAnnocument = false
    //MARK:- ViewcontrollerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        //tblmatterDetail.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0);
        configureTableView(WithLoader: true)
        if !m_FromAnnocument {
            navigationItem.rightBarButtonItems = [plusButton()]
        }else if m_FromAnnocument == true && UserDetail.Instance.genPostAdmin == 1{
             navigationItem.rightBarButtonItems = [plusButton()]
        }
        
        
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
    func configureTableView(WithLoader:Bool) -> Void{
        tblmatterDetail.separatorStyle = .none
        //tblmatterDetail.estimatedRowHeight = 150;
        var url:String?
        if (m_FromAnnocument){
            url = "/getannouncement"
        }else{
            url = "/getcommunication"
        }
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
        MatterParsing.instance.getCommunicationDetailList(url: url!,withLoader:WithLoader, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! MatterDetailModel
                if((model.response?.posts?.count)!>0){
                    self.tblmatterDetail.isHidden = false;
                    self.lblNoRecordFound.isHidden = true;
                    
                    self.dataSource = MatterDetailDataSource.init(delegate: self,tableViews: self.tblmatterDetail, fromAnnoune: self.m_FromAnnocument)
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
        var url:String?
        if (m_FromAnnocument){
            url = "/getannouncement"
        }else{
            url = "/getcommunication"
        }
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
        MatterParsing.instance.getCommunicationDetailList(url: url!,withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! MatterDetailModel
                if((model.response?.posts?.count)!>0){
                    self.tblmatterDetail.isHidden = false;
                    self.lblNoRecordFound.isHidden = true;
                    
                  //  self.dataSource = MatterDetailDataSource.init(delegate: self)
                    self.m_matterArray.append(contentsOf: (model.response?.posts)!)
                    self.dataSource?.m_matterPostDetail = self.m_matterArray
                    self.dataSource?.m_matterTotalCount = model.response?.count
                   // self.dataDelegate = MasterDetailDelegate()
                    
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
    func DeleteTableRow(indexPath: IndexPath) {
        UIView.performWithoutAnimation {
           // m_deleteCount = m_deleteCount + 1
            let object = self.m_matterArray[indexPath.row]
            self.m_matterArray.remove(at: indexPath.row)
            self.dataSource?.m_matterPostDetail?.remove(at: indexPath.row)
            let count = (self.dataSource?.m_matterTotalCount)! - 1
            self.dataSource?.m_matterTotalCount?  = count
            tblmatterDetail.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            if !m_FromAnnocument {
                let param:[String:String] = ["id":UserDetail.Instance.id!,
                                             "userid":UserDetail.Instance.userid!,
                                             "postid":object.id!,
                                             "posttype":m_matterType,
                                             "sessionid":"1"]
                 DeleteRow(params: param)
            }else{
                let param:[String:String] = ["id":UserDetail.Instance.id!,
                                             "userid":UserDetail.Instance.userid!,
                                             "postid":object.id!,
                                             "sessionid":"1"]
                DeleteRow(params: param)
            }
            
          
         
        }
      
    }
    func DeleteRow(params:[String:String])
    {
        if !m_FromAnnocument{
            
            MatterParsing.instance.deleteCommunicationPost(url: "/deletepost",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
                if(statuscode == 200){
                    let model = responsedata as! CommentPostModel
                    print(model.response.msg!)
                    
                }
            })
        }else{
            MatterParsing.instance.deleteAnnouncementPost(url: "/deleteannouncement",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
                if(statuscode == 200){
                    let model = responsedata as! CommentPostModel
                    print(model.response.msg!)
                    
                }
            })
            
        }
        
        
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
        VC.m_updateApiDelegate = self
        VC.m_postId = arrayid!
        navigationController?.pushViewController(VC, animated: true)
        
    }
    func UPdateApi() {
        m_pageCount = 0;
        self.m_matterArray.removeAll()
        configureTableView(WithLoader:false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
