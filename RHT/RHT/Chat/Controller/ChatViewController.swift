//
//  ChatViewController.swift
//  RHT
//
//  Created by kamal on 5/9/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import ApiAI

protocol UpdateCons {
    func update()
}
class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UIScrollViewDelegate{
    
    @IBOutlet weak var vChatInnerView: UIView!
    @IBOutlet weak var vBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var vBottomconstraints: NSLayoutConstraint!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var cvHeightConstrinat: NSLayoutConstraint!
    @IBOutlet weak var tvchatInput: UITextView!
    @IBOutlet weak var cvChat: UITableView!
    @IBOutlet weak var VContainer: UIView!
    
    var delegate: UpdateCons?
    var frameheight:CGFloat?
    var frameheightKeyboard:Int = 0;
    var bottomViewHeight:CGFloat = 0;
    var cell:ChatCell?
    var dataSource:ChatTblSource?
    var dataDelegate:ChatTblDelegate?
    private let cellIdentifier = "ChatCell"
    private let cellIdentifierimage = "imagecell"
    private let cellIdentifiertable = "tableCell"
    private let cellIdentifierright  = "ChatRightCell"
    //  var chatItem = [ChatModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // frameheightKeyboard = vBottomHeight.multiplier
        //  cvChat.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        //        let borderWidth: CGFloat = 1
        //        tvchatInput.frame = tvchatInput.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        //        tvchatInput.layer.borderColor =  AppConstant.sharedInstance.borderChat.cgColor;
        //        tvchatInput.layer.borderWidth = borderWidth
        
        
       
       
        
      
        setUpTextView()
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //AddKeyboardObserver()
        if   AppConstant.sharedInstance.chatItem.count == 0{
            let chat = ChatModel.init(chatMessage: "Hi", userName: UserDetail.Instance.name!, IsSender: true, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text,mtextArray: [],mHeadersText: "")
            AppConstant.sharedInstance.chatItem.append(chat)
             setUpChatTbl()
        }else{
             setUpChatTbl()
            if(AppConstant.sharedInstance.chatItem.count>0)
            {
                let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.attachmentAction(notification:)), name: Notification.Name("TableAction"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.closeAction(notification:)), name: Notification.Name("close"), object: nil)
        AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        RemoveKeyboardObserver()
         NotificationCenter.default.removeObserver(self, name: Notification.Name("TableAction"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("close"), object: nil)
    }
    
    func setUpChatTbl() -> Void{
        cvChat.tableFooterView = UIView(frame: .zero)
        cvChat.separatorStyle = .none
        cvChat.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
        cvChat.register(ImageChatcell.self, forCellReuseIdentifier: cellIdentifierimage)
        cvChat.register(tableCell.self, forCellReuseIdentifier: cellIdentifiertable)
        cvChat.register(ChatRightCell.self, forCellReuseIdentifier: cellIdentifierright)
        self.dataSource = ChatTblSource()
        self.dataDelegate = ChatTblDelegate()
        self.dataSource?.chatItem = AppConstant.sharedInstance.chatItem
        self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
        cvChat.dataSource =  self.dataSource
        cvChat.delegate =  self.dataDelegate
       
        cvChat.reloadData()
      // CloseKeyboard(bool: true)
    }
    func setUpTextView() -> Void{
        tvchatInput.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        tvchatInput.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        tvchatInput.textContainer.lineFragmentPadding = 0;
        //tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
        tvchatInput.font = UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular)
        if(ShareData.isIPhone5()){
            tvchatInput.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhone6()){
            tvchatInput.textContainerInset = UIEdgeInsets.init(top: 15, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhoneX()){
            tvchatInput.textContainerInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 10, right: 10)
        }else if(ShareData.isIPhone6Plus()){
            tvchatInput.textContainerInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 10, right: 10)
        }else{
            tvchatInput.textContainerInset = UIEdgeInsets.init(top: 25, left: 10, bottom: 10, right: 10)
        }
        // vChatInnerView.layer.cornerRadius = 20;
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
    
    //M
    func RemoveKeyboardObserver() -> Void {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    func AddKeyboardObserver() -> Void {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.VContainer.frame.origin.y == 0{
                frameheight = cvChat.frame.height
                bottomViewHeight = vBottomHeight.constant
                if(ShareData.isIPhone5()||ShareData.isIPhone6()||ShareData.isIPhone6Plus())
                {
                    let getheight = cvChat.frame.height - keyboardSize.height
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    // vBottomconstraints.isActive = false;
                    //cvHeightConstrinat.constant =  cvHeightConstrinat.multiplier - getheight
                    self.view.layoutIfNeeded()
                    print(getheight/VContainer.frame.height)
                    
                }else if(ShareData.isIPhoneX()){
                    
                    let getheight = (cvChat.frame.height - keyboardSize.height)+30
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    // vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                    
                }else if(ShareData.isIpad()){
                    
                    let getheight = (cvChat.frame.height - keyboardSize.height)
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    // vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                    
                }
                if(AppConstant.sharedInstance.chatItem.count>0)
                {
                    let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                    cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
                    
                }
                
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if frameheight != nil{
             vBottomHeight.constant =   vBottomHeight.constant - CGFloat(frameheightKeyboard);
             let getheight = (cvChat.frame.height + keyboardSize.height)
            cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
           
          //  vBottomHeight.constant =   0.0;
            frameheightKeyboard = 0
            cvChat.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()

        }
        if(AppConstant.sharedInstance.chatItem.count>0)
        {
            let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
            cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
        }
    }
}
    
    //MARK: -TEXTVIEWDELEGATE
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("I'm scrolling!")
    }
    var previousRect = CGRect.zero
    func textViewDidChange(_ textView: UITextView) {
        let pos = textView.endOfDocument
        let currentRect = textView.caretRect(for: pos)
        self.previousRect = self.previousRect.origin.y == 0.0 ? currentRect : previousRect
        if(currentRect.origin.y > previousRect.origin.y){
            //new line reached, write your code
            print("Started New Line")
//            let sizes = ShareData.sharedInstance.GetchatStringCGSize(stringValue:tvchatInput.text , font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular), width: Int(tvchatInput.frame.width))
            ////  let countheitn = Int(sizes.height)
            let getheight =  cvChat.frame.height - 15
           //frameheight = cvChat.frame.height - 15
            if(frameheight != nil){
                if(frameheight!/2.5<cvChat.frame.height-15)
                {
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    frameheightKeyboard = frameheightKeyboard + 15;
                    vBottomHeight.constant =  vBottomHeight.constant + 15; 
                }
            }
        }else if(currentRect.origin.y < previousRect.origin.y) {
            
            let getheight =  cvChat.frame.height + 15

            if(frameheight != nil){
                if(vBottomHeight.constant != 0.0)
                {
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    frameheightKeyboard = frameheightKeyboard - 15;
                    debugPrint(vBottomHeight.constant - 15)
                    if vBottomHeight.constant != 0.0 {
                        vBottomHeight.constant =  vBottomHeight.constant - 15;
                    }
                }
            }
            
        }
        previousRect = currentRect
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        //if()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            print("\n" + "is printed")
            let getheight =  cvChat.frame.height - 15
            if(frameheight != nil){
                if(frameheight!/2.5<cvChat.frame.height-15)
                {
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    frameheightKeyboard = frameheightKeyboard + 15;
                    vBottomHeight.constant =  vBottomHeight.constant+15;
                }
            }
        }
        return true
    }
    @objc func closeAction(notification: Notification){
        self.view.endEditing(true);
    }
    @objc func attachmentAction(notification: Notification){
        let text = notification.userInfo?["Sender"] as? String
        
        let chat = ChatModel.init(chatMessage:text! , userName: UserDetail.Instance.name!, IsSender: false, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text,mtextArray: [],mHeadersText: "")
        AppConstant.sharedInstance.chatItem.append(chat)
        UIView.performWithoutAnimation {
            self.dataSource?.chatItem =   AppConstant.sharedInstance.chatItem
            self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
            let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
            self.cvChat.insertRows(at: [index], with: UITableViewRowAnimation.fade)
            self.cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
        }
        ChatResponse(chatText:text!)
    }
    //MARK:-ButtonAction
    @IBAction func SendButtonAction(_ sender: Any) {
        if  tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines).count>0{
            
            let chat = ChatModel.init(chatMessage: tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines), userName: UserDetail.Instance.name!, IsSender: false, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text,mtextArray: [],mHeadersText: "")
            AppConstant.sharedInstance.chatItem.append(chat)
            UIView.performWithoutAnimation {
                self.dataSource?.chatItem =   AppConstant.sharedInstance.chatItem
                self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
                let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                self.cvChat.insertRows(at: [index], with: UITableViewRowAnimation.fade)
                self.cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
            }
            ChatResponse(chatText: tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
    }
    func ChatResponse (chatText:String){
        let  request = ApiAI.shared().textRequest()
        request?.query = [chatText]
//        request?.setCompletionBlockSuccess({ (request, response) in
//
//            print(response )
//        }, failure: { (request, error) in
//
//        })
        request?.setMappedCompletionBlockSuccess({ (request, response) in
           // print(response)
            let response = response as! AIResponse
          //  let textResponse = response.timestamp
            let action = response.result.action
            if  action  != "input.unknown" {
                let responemessage = response.result.fulfillment.messages[0]["speech"]!
                let chat = ChatModel.init(chatMessage: responemessage as! String, userName: "Agent", IsSender: true, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text, mtextArray: [],mHeadersText: "")
                AppConstant.sharedInstance.chatItem.append(chat)
                UIView.performWithoutAnimation {
                    self.dataSource?.chatItem =   AppConstant.sharedInstance.chatItem
                    self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
                    let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                    self.cvChat.insertRows(at: [index], with: UITableViewRowAnimation.automatic)
                    self.cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
                }
                print(response.result)
            }else{
                let responemessage1 = response.result.fulfillment.messages[1]["textToSpeech"]! as! String
                debugPrint(responemessage1)
                let responemessage2 = response.result.fulfillment.messages[2]["suggestions"]!
                debugPrint(responemessage2)
                let chat = ChatModel.init(chatMessage: "", userName: "Agent", IsSender: true, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.multiple, mtextArray: responemessage2 as! [[String : AnyObject]],mHeadersText:responemessage1 )
                AppConstant.sharedInstance.chatItem.append(chat)
                UIView.performWithoutAnimation {
                    self.dataSource?.chatItem =   AppConstant.sharedInstance.chatItem
                    self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
                    let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                    self.cvChat.insertRows(at: [index], with: UITableViewRowAnimation.automatic)
                    self.cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
                }
            }
            
        }, failure: { (request, error) in
            print(error!)
        })
        ApiAI.shared().enqueue(request)
        tvchatInput.text = ""
    
        let getheight =  cvChat.frame.height + CGFloat(frameheightKeyboard)
        cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier:getheight / VContainer.frame.height , constant: 0).isActive=true
        vBottomHeight.constant =   0.0;
        frameheightKeyboard = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
