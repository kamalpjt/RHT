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
class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate {
    
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
    var cell:ChatCell?
    var dataSource:ChatTblSource?
    var dataDelegate:ChatTblDelegate?
    private let cellIdentifier = "ChatCell"
    private let cellIdentifierimage = "imagecell"
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
            let chat = ChatModel.init(chatMessage: "Hi", userName: "john", IsSender: true, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text)
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
        
        AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        RemoveKeyboardObserver()
    }
    
    func setUpChatTbl() -> Void{
        cvChat.tableFooterView = UIView(frame: .zero)
        cvChat.separatorStyle = .none
        cvChat.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
        cvChat.register(ImageChatcell.self, forCellReuseIdentifier: cellIdentifierimage)
        self.dataSource = ChatTblSource()
        self.dataDelegate = ChatTblDelegate()
        self.dataSource?.chatItem = AppConstant.sharedInstance.chatItem
        self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
        cvChat.dataSource =  self.dataSource
        cvChat.delegate =  self.dataDelegate
        cvChat.reloadData()
        CloseKeyboard(bool: true)
    }
    func setUpTextView() -> Void{
        tvchatInput.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        tvchatInput.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        tvchatInput.textContainer.lineFragmentPadding = 0;
        //tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
        tvchatInput.font = UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular)
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
        
        if frameheight != nil{
            cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: frameheight!/VContainer.frame.height , constant: 0).isActive=true
            vBottomHeight.constant =  vBottomHeight.constant - CGFloat(frameheightKeyboard);
            frameheightKeyboard = 0
            
        }
        if(AppConstant.sharedInstance.chatItem.count>0)
        {
            let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
            cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: true)
        }
    }
    
    //MARK: -TEXTVIEWDELEGATE
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
    //MARK:-ButtonAction
    @IBAction func SendButtonAction(_ sender: Any) {
        if  tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines).count>0{
            
            let chat = ChatModel.init(chatMessage: tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines), userName: "john", IsSender: false, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text)
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
            let responemessage = response.result.fulfillment.messages[0]["speech"]!
            let chat = ChatModel.init(chatMessage: responemessage as! String, userName: "john", IsSender: true, date:ShareData.sharedInstance.GetCurrentDateAndTime(),imageUrl: "" , mType: MessageType.text)
            AppConstant.sharedInstance.chatItem.append(chat)
            UIView.performWithoutAnimation {
                self.dataSource?.chatItem =   AppConstant.sharedInstance.chatItem
                self.dataDelegate?.chatItem = AppConstant.sharedInstance.chatItem
                let index = IndexPath(item: AppConstant.sharedInstance.chatItem.count-1, section: 0)
                self.cvChat.insertRows(at: [index], with: UITableViewRowAnimation.automatic)
                self.cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
            }
            
            print(response.result)
        }, failure: { (request, error) in
            print(error!)
        })
        ApiAI.shared().enqueue(request)
        tvchatInput.text = ""
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
