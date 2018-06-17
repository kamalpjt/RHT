//
//  CommunicationDetailController.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit



class CommunicationDetailController: UIViewController,UITableViewDelegate {
    
    
    @IBOutlet weak var tblmatterDetail: UITableView!
    private let cellIdentifier = "MatterCell"
    // var cell:MatterDetailCell?
    var dataSource:MatterDetailDataSource?
    var dataDelegate:MasterDetailDelegate?
    var matterType:String = "";
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
        self.dataSource = MatterDetailDataSource()
        self.dataDelegate = MasterDetailDelegate()
        tblmatterDetail.dataSource = dataSource
        tblmatterDetail.delegate = dataDelegate
        tblmatterDetail.reloadData()
        
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
        vc.matterType = matterType
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func CommentAction(notification: Notification){
        let VC = ImageListController()
        navigationController?.pushViewController(VC, animated: true)
        
    }
    @objc func CommentListAction(notification: Notification){
        let VC = ChatListController()
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
