//
//  ChatViewController.swift
//  RHT
//
//  Created by kamal on 5/9/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

protocol UpdateCons {
    
    func update()
}
class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate {
    
    @IBOutlet weak var vChatInnerView: UIView!
    
    @IBOutlet weak var vBottomHeight: NSLayoutConstraint!
    
    var delegate: UpdateCons?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var vBottomconstraints: NSLayoutConstraint!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var cvHeightConstrinat: NSLayoutConstraint!
    @IBOutlet weak var tvchatInput: UITextView!
    @IBOutlet weak var cvChat: UITableView!
    @IBOutlet weak var VContainer: UIView!
    var frameheight:CGFloat?
    var frameheightKeyboard:Int = 0;
    var cell:ChatCell?
    var dataSource:ChatTblSource?
    var dataDelegate:ChatTblDelegate?
    private let cellIdentifier = "ChatCell"
    private let cellIdentifierimage = "imagecell"
    var chatItem = [ChatModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvchatInput.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        tvchatInput.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        tvchatInput.textContainer.lineFragmentPadding = 0;
        //tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
        cvChat.tableFooterView = UIView(frame: .zero)
        cvChat.separatorStyle = .none
        tvchatInput.font = UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular)
        // frameheightKeyboard = vBottomHeight.multiplier
        //  cvChat.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        //        let borderWidth: CGFloat = 1
        //        tvchatInput.frame = tvchatInput.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        //        tvchatInput.layer.borderColor =  AppConstant.sharedInstance.borderChat.cgColor;
        //        tvchatInput.layer.borderWidth = borderWidth
        
        vChatInnerView.layer.cornerRadius = 20;
        let chat = ChatModel.init(chatMessage: "Hi", userName: "john", IsSender: true, date:"12/100/201",imageUrl: "" , mType: MessageType.text)
        let chat1 = ChatModel.init(chatMessage: "Hi", userName: "john", IsSender: false, date:"12/100/201",imageUrl: "Dravid" , mType: MessageType.image)
         let chat2 = ChatModel.init(chatMessage: "Hi", userName: "john", IsSender: true, date:"12/100/201",imageUrl: "Pdf" , mType: MessageType.image)
        chatItem.append(chat)
        chatItem.append(chat1)
         chatItem.append(chat2)
        
        
        
        
        cvChat.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)
        cvChat.register(ImageChatcell.self, forCellReuseIdentifier: cellIdentifierimage)
        self.dataSource = ChatTblSource()
        self.dataDelegate = ChatTblDelegate()
        self.dataSource?.chatItem = chatItem
        self.dataDelegate?.chatItem = chatItem
        cvChat.dataSource =  self.dataSource
        cvChat.delegate =  self.dataDelegate
        cvChat.reloadData()
        CloseKeyboard(bool: true)
        // Do any additional setup after loading the view.
        
        
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
    override func viewWillAppear(_ animated: Bool) {
        //AddKeyboardObserver()
        AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        RemoveKeyboardObserver()
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
                if(chatItem.count>0)
                {
                    let index = IndexPath(item: chatItem.count-1, section: 0)
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
        if(chatItem.count>0)
        {
            let index = IndexPath(item: chatItem.count-1, section: 0)
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
            let value = chatItem[chatItem.count-1]
            let items =  ChatModel.init(chatMessage: tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines), userName:"Jack123456", IsSender: value.IsSender == true ? false:true, date: "12/03/1990",imageUrl: "", mType: MessageType.text);
            chatItem.append(items)
            // print(tvchatInput.text)
            tvchatInput.text = ""
            //self.dataSource = ChatTblSource(item: chatItem)
            //cvChat.dataSource = dataSource
            UIView.performWithoutAnimation {
                self.dataSource?.chatItem = chatItem
                self.dataDelegate?.chatItem = chatItem
                let index = IndexPath(item: chatItem.count-1, section: 0)
                cvChat.insertRows(at: [index], with: UITableViewRowAnimation.fade)
                cvChat.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: false)
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
