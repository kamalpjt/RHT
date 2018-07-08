//
//  ChatListController.swift
//  RHT
//
//  Created by kamal on 21/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
protocol UpdateApiDelegate {
    
    func UPdateApi()
}
class ChatListController: UIViewController,UITextViewDelegate{
    
    var vContainer = UIView()
    var tblCommentList = UITableView()
    var vTextContainer = UIView()
    var tvTextInPutContainer = UITextView()
    var  butSend = UIButton(type: UIButtonType.custom) as UIButton
  //  var m_CommentArray = [CommetList]
    var chatItem = [CommetList]()
    var dataSource:CommentTblSource?
    var dataDelegate:ChatCommentDelegate?
    private let cellIdentifier = "CommentCell"
    var frameheight:CGFloat?
    var frameheightKeyboard:CGFloat = 0.0;
    var vBottomConstrainr:NSLayoutConstraint?
    var m_pageCount = 0
    var m_postId:String?
    var m_updateApiDelegate:UpdateApiDelegate?
    
    
    //MARK:- ViewcontrollerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddView()
        setupConstraints()
        AddKeyboardObserver()
        SetUpSendButton()
        SetUpList()
        SetUpTextView()
        CloseKeyboard(bool: true)
        SetUpCommentList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RemoveKeyboardObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //MARK:Common Funcation
    func SetUpList()
    {
        let chat = ChatModel.init(chatMessage: "Hi", userName: "john", IsSender: true, date:"12/100/201",imageUrl: "" , mType: MessageType.text)
        //chatItem.append(chat)
        tblCommentList.register(CommentCell.self, forCellReuseIdentifier: cellIdentifier)
//        self.dataSource = CommentTblSource()
//        self.dataDelegate = ChatCommentDelegate()
//        self.dataSource?.chatItem = chatItem
//        self.dataDelegate?.chatItem = chatItem
//        tblCommentList.dataSource =  self.dataSource
//        tblCommentList.delegate =  self.dataDelegate
//        tblCommentList.reloadData()
        tblCommentList.tableFooterView = UIView(frame: .zero)
        tblCommentList.separatorStyle = .none
    }
    func SetUpTextView(){
        tvTextInPutContainer.delegate = self
        tvTextInPutContainer.text = "Type your comment..."
        tvTextInPutContainer.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular)
        tvTextInPutContainer.textColor = UIColor.white
        
        if(ShareData.isIPhone5()){
            tvTextInPutContainer.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhone6()){
            tvTextInPutContainer.textContainerInset = UIEdgeInsets.init(top: 15, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhoneX()){
            tvTextInPutContainer.textContainerInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhone6Plus()){
            tvTextInPutContainer.textContainerInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 10, right: 10)
        }else{
            tvTextInPutContainer.textContainerInset = UIEdgeInsets.init(top: 25, left: 10, bottom: 10, right: 10)
        }
        tvTextInPutContainer.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        tvTextInPutContainer.textContainer.lineFragmentPadding = 0;
    }
    func SetUpCommentList()
    {
        m_pageCount  = m_pageCount + 1
        let params:[String:String] = ["id":UserDetail.Instance.id!,
                                      "userid":UserDetail.Instance.userid!,
                                      "sessionid":"1",
                                      "page": String(m_pageCount),
                                      "user_type": UserDetail.Instance.user_type!,
                                      "postid": m_postId!,
                                      "pagesize":"1000000"]
        MatterParsing.instance.getCommentList(url: "/getcomment",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! CommentListModel
                if((model.response.comments?.count)!>0){
//                    self.cvCollectionView.isHidden = false;
//                    //self.lblNoRecord.isHidden = true
//                    self.dataSource = LeaderDataSource.init(delegate: self,htmlDelgate: self)
//                    self.m_NewsArray = self.m_NewsArray +  model.response.posts!
                      self.dataSource = CommentTblSource()
                      self.dataDelegate = ChatCommentDelegate()
                       self.chatItem = self.chatItem + model.response.comments!
                    
                      self.dataSource?.chatItem = self.chatItem;
                      self.dataDelegate?.chatItem = self.chatItem
                      self.dataSource?.m_TotalCount = model.response.count;
                      self.tblCommentList.dataSource = self.dataSource;
                      self.tblCommentList.delegate = self.dataDelegate;
                      self.tblCommentList.reloadData()
                    //self.cvt.dataSource = self.dataSource
//                    self.cvCollectionView.delegate = self.dataSource
//                    self.cvCollectionView.reloadData()
                }else{
                   // self.cvCollectionView.isHidden = true;
                    //self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    func CloseKeyboard(bool:Bool) -> Void {
        if(bool){
            // view.endEditing(true);
            let tap = UITapGestureRecognizer(target: self, action:#selector(handleTap))
            self.view.addGestureRecognizer(tap)
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func RemoveKeyboardObserver() -> Void {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    func AddKeyboardObserver() -> Void {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
           if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.vContainer.frame.origin.y == 0{
                 frameheight = tblCommentList.frame.height
                
                if(ShareData.isIPhone5()||ShareData.isIPhone6()||ShareData.isIPhone6Plus())
                {
                    let getheight = tblCommentList.frame.height - keyboardSize.height
                    tblCommentList.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: getheight/vContainer.frame.height , constant: 0).isActive=true
                   self.view.layoutIfNeeded()
                }else if(ShareData.isIPhoneX()){
                    
                    let getheight = (tblCommentList.frame.height - keyboardSize.height)+30
                    tblCommentList.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: getheight/vContainer.frame.height , constant: 0).isActive=true
                   self.view.layoutIfNeeded()
                    
                }else if(ShareData.isIpad()){
                    
                    let getheight = (tblCommentList.frame.height - keyboardSize.height)
                    tblCommentList.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: getheight/vContainer.frame.height , constant: 0).isActive=true
                    self.view.layoutIfNeeded()
                }
                if(chatItem.count>0)
                {
                    let index = IndexPath(item: chatItem.count-1, section: 0)
                    tblCommentList.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
                }
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        tvTextInPutContainer.text = "Type your comment.."
        if frameheight != nil{
            tblCommentList.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: frameheight!/vContainer.frame.height , constant: 0).isActive=true
            //NSLayoutConstraint(item: vTextContainer, attribute: .height, relatedBy: .equal,
                          //     toItem: vContainer, attribute: .height,
                           //    multiplier: 0.08, constant: 0.0).isActive=true
            vBottomConstrainr?.constant = (vBottomConstrainr?.constant)! - frameheightKeyboard
            frameheightKeyboard = 0.0
            if(chatItem.count>0)
            {
                let index = IndexPath(item: chatItem.count-1, section: 0)
                tblCommentList.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
            }
            
            
        }
    }
    func AddView()
    {
        vContainer.translatesAutoresizingMaskIntoConstraints = false
        tblCommentList.translatesAutoresizingMaskIntoConstraints = false
        vTextContainer.translatesAutoresizingMaskIntoConstraints = false
        tvTextInPutContainer.translatesAutoresizingMaskIntoConstraints = false
        butSend.translatesAutoresizingMaskIntoConstraints = false;
        
        vContainer.backgroundColor = UIColor.white
        vTextContainer.backgroundColor = AppConstant.sharedInstance.backGroundColor
        tvTextInPutContainer.backgroundColor = AppConstant.sharedInstance.backGroundColor
        butSend.backgroundColor = AppConstant.sharedInstance.backGroundColor
        
        self.view.addSubview(vContainer)
        self.vContainer.addSubview(tblCommentList)
        self.vContainer.addSubview(vTextContainer)
        self.vTextContainer.addSubview(tvTextInPutContainer)
        self.vTextContainer.addSubview(butSend)
  //      tblCommentList.backgroundColor = UIColor.orange
        
    }
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            let safeGuide = self.view.safeAreaLayoutGuide
            vContainer.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
            vContainer.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
            vContainer.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
            vContainer.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            vContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            vContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            vContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            vContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        //tblCommentList
        tblCommentList.leadingAnchor.constraint(equalTo: vContainer.leadingAnchor).isActive = true
        tblCommentList.trailingAnchor.constraint(equalTo: vContainer.trailingAnchor).isActive = true
        tblCommentList.topAnchor.constraint(equalTo: vContainer.topAnchor).isActive = true
        NSLayoutConstraint(item: tblCommentList, attribute: .height, relatedBy: .equal,
                           toItem: vContainer, attribute: .height,
                           multiplier: 0.92, constant: 0.0).isActive=true
        //vTextContainer
        vTextContainer.leadingAnchor.constraint(equalTo: vContainer.leadingAnchor).isActive = true
        vTextContainer.trailingAnchor.constraint(equalTo: vContainer.trailingAnchor).isActive = true
        vTextContainer.topAnchor.constraint(equalTo: tblCommentList.bottomAnchor).isActive = true
        vBottomConstrainr = NSLayoutConstraint(item: vTextContainer, attribute: .height, relatedBy: .equal,
                           toItem: vContainer, attribute: .height,
                           multiplier: 0.08, constant: 0.0)
        vBottomConstrainr?.isActive = true;
       // vTextContainer.bottomAnchor.constraint(equalTo: vContainer.bottomAnchor).isActive = true
        
        //tvTextInPutContainer
        tvTextInPutContainer.leadingAnchor.constraint(equalTo: vTextContainer.leadingAnchor).isActive = true
        NSLayoutConstraint(item: tvTextInPutContainer, attribute: .width, relatedBy: .equal,
                           toItem: vTextContainer, attribute: .width,
                           multiplier: 0.81, constant: 0.0).isActive=true
        tvTextInPutContainer.topAnchor.constraint(equalTo: vTextContainer.topAnchor).isActive = true
        tvTextInPutContainer.bottomAnchor.constraint(equalTo: vTextContainer.bottomAnchor).isActive = true
        
        //tvTextInPutContainer
        butSend.leadingAnchor.constraint(equalTo: tvTextInPutContainer.trailingAnchor).isActive = true
        butSend.trailingAnchor.constraint(equalTo: vTextContainer.trailingAnchor, constant: 0.0).isActive = true
        butSend.topAnchor.constraint(equalTo: vTextContainer.topAnchor).isActive = true
        butSend.bottomAnchor.constraint(equalTo: vTextContainer.bottomAnchor).isActive = true
        
    }
    //MARK:TextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvTextInPutContainer.text = ""
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n"){
            print("\n" + "is printed")
            let getheight =  tblCommentList.frame.height - 15
            //var frame:CGFloat = 0.08
            if(frameheight != nil){
                if(frameheight!/3<tblCommentList.frame.height-15)
                {
                    tblCommentList.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: getheight/vContainer.frame.height , constant: 0).isActive=true
                    frameheightKeyboard = frameheightKeyboard + 15
                    vBottomConstrainr?.constant = (vBottomConstrainr?.constant)! + 15
                    
                }
            }
        }
        return true
    }
    //MARK:Action
    func SetUpSendButton()
    {
        butSend.setTitle("Send", for: UIControlState.normal)
        butSend.titleLabel?.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular)
        butSend.titleLabel?.textColor = UIColor.white
        butSend.addTarget(self, action: #selector(messageSendAction), for: UIControlEvents.touchUpInside)
    }
    @objc func messageSendAction(sender:UIButton!) {
        if  tvTextInPutContainer.text.trimmingCharacters(in: .whitespacesAndNewlines).count>0{
            let commmentText =    tvTextInPutContainer.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let commentdata:[String:Any] = ["comment":commmentText ,"sendername":UserDetail.Instance.name ?? "","createddate":"12/34/1212" ]
            chatItem.append(CommetList.init(json:commentdata ))
             tvTextInPutContainer.text = ""
            let param:[String:String] = ["id":UserDetail.Instance.id!,
                                         "userid":UserDetail.Instance.userid!,
                                         "comment":commmentText,
                                         "postid":m_postId!,
                                         "user_type":UserDetail.Instance.user_type!,
                                         "sendername":UserDetail.Instance.name!]
            if(chatItem.count>1)
            {
                UIView.performWithoutAnimation {
                    self.dataSource?.chatItem = chatItem
                    self.dataDelegate?.chatItem = chatItem
                    let index = IndexPath(item: chatItem.count-1, section: 0)
                    tblCommentList.insertRows(at: [index], with: UITableViewRowAnimation.fade)
                    tblCommentList.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
                }
                
            }else{
                self.dataSource = CommentTblSource()
                self.dataDelegate = ChatCommentDelegate()
               // self.chatItem = self.chatItem + model.response.comments!
                self.dataSource?.chatItem = self.chatItem;
                self.dataDelegate?.chatItem = self.chatItem
                self.dataSource?.m_TotalCount = self.chatItem.count
                self.tblCommentList.dataSource = self.dataSource;
                self.tblCommentList.delegate = self.dataDelegate;
                self.tblCommentList.reloadData()
            }
           
            MatterParsing.instance.addCommentPost(url: "/postcomment",withLoader: true, param: param, resposneBlock: { responsedata , statuscode in
                if(statuscode == 200){
                    let model = responsedata as! CommentPostModel
                    print(model.response.msg!)
                    self.m_updateApiDelegate?.UPdateApi()
                    
                }
            })
        }
        
        
    }
    
}
