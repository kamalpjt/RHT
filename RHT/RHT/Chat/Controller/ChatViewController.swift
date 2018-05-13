//
//  ChatViewController.swift
//  RHT
//
//  Created by kamal on 5/9/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var vBottomconstraints: NSLayoutConstraint!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var cvHeightConstrinat: NSLayoutConstraint!
    @IBOutlet weak var tvchatInput: UITextView!
    @IBOutlet weak var cvChat: UICollectionView!
    @IBOutlet weak var VContainer: UIView!
    var frameheight:CGFloat?
    var cell:ChatCell?
    var dataSource:ChatSource?
    var collectionviewDelegates:ChatFlowDelegate?
    private let cellIdentifier = "ChatCell"
    var chatItem = [ChatData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // addButton.setBackgroundImage(UIImage.init(named: "Add"), for: UIControlState.normal);
        tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
       // tvchatInput.layer.borderColor = UIColor.lightText.cgColor
       // tvchatInput.layer.borderWidth=1;
        
        let borderWidth: CGFloat = 1
        tvchatInput.frame = tvchatInput.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        tvchatInput.layer.borderColor =  AppConstant.sharedInstance.borderChat.cgColor;
        tvchatInput.layer.borderWidth = borderWidth
       // addButton.imageView?.image?.imageRendererFormat.alwa
        var chat = ChatData()
        chat.chatMessage = "message1232232323232"+"\n"+"3232323232323232323"
        chat.userName = "john"
        chat.IsSender = true
        chat.date = "12/100/2019"
        
        var chat1 = ChatData()
        chat1.chatMessage = "message12322323232323232"+"\n"+"323232323232323ddd"+"\n"+"fdfdfdfdfdfdfddfdfdfdf"
        chat1.userName = "john1"
        chat1.IsSender = true
        chat1.date = "12/100/2019"
        
        var chat2 = ChatData()
        chat2.chatMessage = "message123223\n232323232323232\n32323232323dd/ndfdfdfdfdfdfdf\nddfdfdfdf5454"
        chat2.userName = "john2"
        chat2.IsSender = false
        chat2.date = "12/100/2019"
        
        var chat3 = ChatData()
        chat3.chatMessage = "message123223\n2323232323232323\n2323232323dd/ndfdfdfdfdfdfdfd\ndfdfdfdf675\n67567567"
        chat3.userName = "john3"
        chat3.IsSender = false
        chat3.date = "12/100/2019"
        
        chatItem.append(chat)
        chatItem.append(chat1)
        chatItem.append(chat2)
        chatItem.append(chat3)
        
        self.collectionviewDelegates = ChatFlowDelegate(item: chatItem);
        self.dataSource = ChatSource(item: chatItem)
        cvChat.register(ChatCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cvChat.dataSource = dataSource;
        cvChat.delegate = collectionviewDelegates;
        cvChat.reloadData()
        // Do any additional setup after loading the view.
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //AddKeyboardObserver()
         AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
     RemoveKeyboardObserver()
    }
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
                let getheight = cvChat.frame.height - keyboardSize.height
                cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                 vBottomconstraints.isActive = false;
                self.view.layoutIfNeeded()
            }
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
        if vBottomconstraints.isActive==false{
            
            cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: frameheight!/VContainer.frame.height , constant: 0).isActive=true
            vBottomconstraints.isActive=true;
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        //if()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
