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
class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate {
   
    
    
    var delegate: UpdateCons?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var vBottomconstraints: NSLayoutConstraint!
    @IBOutlet weak var vBottom: UIView!
    @IBOutlet weak var cvHeightConstrinat: NSLayoutConstraint!
    @IBOutlet weak var tvchatInput: UITextView!
    @IBOutlet weak var cvChat: UITableView!
    @IBOutlet weak var VContainer: UIView!
    var frameheight:CGFloat?
    var cell:ChatCell?
    var dataSource:ChatTblSource?
    private let cellIdentifier = "ChatCell"
    var chatItem = [ChatData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvchatInput.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        tvchatInput.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        tvchatInput.textContainer.lineFragmentPadding = 0;
        tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
        cvChat.tableFooterView = UIView(frame: .zero)
        cvChat.separatorStyle = .none
        tvchatInput.font = UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular)
      //  cvChat.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
      
        let borderWidth: CGFloat = 1
        tvchatInput.frame = tvchatInput.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        tvchatInput.layer.borderColor =  AppConstant.sharedInstance.borderChat.cgColor;
        tvchatInput.layer.borderWidth = borderWidth
      
        
        var chat = ChatData()
        chat.chatMessage = "Hi"
        chat.userName = "john"
        chat.IsSender = true
        chat.date = "12/100/2019"
        chatItem.append(chat)

        
       
        self.dataSource = ChatTblSource()
        cvChat.register(ChatCell.self, forCellReuseIdentifier: cellIdentifier)

        self.dataSource?.chatItem = chatItem
        cvChat.dataSource =  self.dataSource
        cvChat.delegate =  self
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
                    vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                    
                }else if(ShareData.isIPhoneX()){
                    
                   let getheight = (cvChat.frame.height - keyboardSize.height)+30
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                    
                }else if(ShareData.isIpad()){
                    
                    let getheight = (cvChat.frame.height - keyboardSize.height)
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    vBottomconstraints.isActive = false;
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
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    @IBAction func SendButtonAction(_ sender: Any) {
        if  tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines).count>0{
            var bools = true;
            let value = chatItem[chatItem.count-1]
            var items =  ChatData();
            items.chatMessage = tvchatInput.text.trimmingCharacters(in: .whitespacesAndNewlines);
            items.date = "date"
            items.userName = "Jack123456"
            items.IsSender = value.IsSender == true ? false:true
            chatItem.append(items)
            print(tvchatInput.text)
            tvchatInput.text = ""
            //self.dataSource = ChatTblSource(item: chatItem)
             //cvChat.dataSource = dataSource
            UIView.performWithoutAnimation {
                 self.dataSource?.chatItem = chatItem
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let messagetext = chatItem[indexPath.row].chatMessage{
            
            print(messagetext);
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
            let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            
            return estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+30;
        }else{
             print("error")
            return 0
           
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = cvChat.dequeueReusableCell(withIdentifier: cellIdentifier) as! ChatCell
        let item = chatItem[indexPath.row]
        cell.BindValue(chatitem: item)
        return cell
        
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
