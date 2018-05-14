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
class ChatViewController: UIViewController,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var delegate: UpdateCons?
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
        
        tvchatInput.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        tvchatInput.layer.cornerRadius=5;
        tvchatInput.layer.masksToBounds = true;
      
        let borderWidth: CGFloat = 1
        tvchatInput.frame = tvchatInput.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        tvchatInput.layer.borderColor =  AppConstant.sharedInstance.borderChat.cgColor;
        tvchatInput.layer.borderWidth = borderWidth
      
        
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
        
        var chat4 = ChatData()
        chat4.chatMessage = "message123223\n2323232323232323\n2323232323dd/ndfdfdfdfdfdfdfd\ndfdfdfdf675\n67567567"
        chat4.userName = "john4"
        chat4.IsSender = false
        chat4.date = "12/100/2019"
        
        chatItem.append(chat)
        chatItem.append(chat1)
        chatItem.append(chat2)
        chatItem.append(chat3)
        chatItem.append(chat4)
        
        self.collectionviewDelegates = ChatFlowDelegate(item: chatItem);
        self.dataSource = ChatSource(item: chatItem)
        cvChat.register(ChatCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cvChat.dataSource = self;
        cvChat.delegate = self;
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
                if(!ShareData.isIPhoneX())
                {
                    let getheight = cvChat.frame.height - keyboardSize.height
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                }else if(!ShareData.isIpad()){
                    
                    let getheight = (cvChat.frame.height - keyboardSize.height)+30
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
                    
                }else{
                    let getheight = (cvChat.frame.height - keyboardSize.height)+20
                    cvChat.heightAnchor.constraint(equalTo: VContainer.heightAnchor, multiplier: getheight/VContainer.frame.height , constant: 0).isActive=true
                    vBottomconstraints.isActive = false;
                    self.view.layoutIfNeeded()
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
        var bools = true;
        var items =  ChatData();
        items.chatMessage = tvchatInput.text;
        items.date = "date"
        items.userName = "Jack123456"
         items.IsSender = true
//        if chatItem.count % 2 == 0{
//
//        }else{
//            items.IsSender = false
//        }
        chatItem.append(items)
        print(tvchatInput.text)
        tvchatInput.text = "";
//        self.collectionviewDelegates = ChatFlowDelegate(item: chatItem);
//        self.dataSource = ChatSource(item: chatItem)
//        cvChat.reloadData()
       // tvchatInput.text = "";
        
        
       // self.collectionviewDelegates = ChatFlowDelegate(item: chatItem);
       // self.dataSource = ChatSource(item: chatItem)
       // cvChat.register(ChatCell.self, forCellWithReuseIdentifier: cellIdentifier)
       // cvChat.dataSource = dataSource;
      //  cvChat.delegate = collectionviewDelegates;
       // cvChat.reloadData()
        //self.cvChat
        
      cvChat?.performBatchUpdates({
            let index = chatItem.count-1;
            let indexPaths = IndexPath(row:index, section: 0) //at some index
        //  self.cvChat.numberOfItems(inSection: 1)
        cvChat.dataSource  = self
            self.cvChat.insertItems(at: [indexPaths])
       //  self.cvChat.reloadData()
        //self.cvChat.re
            //self.cvChat.reloadItems(at: [indexPaths])
//           // self.cvChat.inr(at: [num index])
//            print("First part")
        }, completion: { (result: Bool) in
//            print("Second part")
            //self.cvChat.reloadData()
        })
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let num = chatItem.count;
        print(num)
        return num;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ChatCell;
        let item  = self.chatItem[indexPath.row];
        cell.BindValue(chatitem: item)
        
//        let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: item.chatMessage!, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
//        
//        let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:item.userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
//        
//        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:item.date!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
//        if(item.IsSender)!
//        {
//            cell.lblUserName.frame = CGRect(x: 0, y: 0, width: estimatedFramename.width, height: estimatedFramename.height)
//            cell.tvChat.frame = CGRect(x: 10, y: cell.lblUserName.frame.height+4, width: estimatedFramemessage.width, height: estimatedFramemessage.height)
//           cell.lblDate .frame = CGRect(x: 0, y: cell.tvChat.frame.height+4, width: estimatedFramedate.width, height: estimatedFramedate.height)
//            
//        }else{
//             cell.lblUserName.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: estimatedFramename.width, height: estimatedFramename.height)
//            cell.tvChat.frame = CGRect(x: UIScreen.main.bounds.width-estimatedFramemessage.width, y: cell.lblUserName.frame.height+4, width: estimatedFramemessage.width, height: estimatedFramemessage.height)
//            //  addSubview(tvChat)
//            cell.lblDate .frame = CGRect(x: 0, y: cell.tvChat.frame.height+4, width: estimatedFramedate.width, height: estimatedFramedate.height)
//        }
        return cell;
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //check the postive value first
       // var num = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
       // num.BindValue(chatitem: chatItem[indexPath.row]);
        
        if let messagetext = chatItem[indexPath.row].chatMessage{
            
            print(messagetext);
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
            let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            
            return CGSize.init(width: UIScreen.main.bounds.size.width, height: (estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+16));
        }else{
            return CGSize.init(width: UIScreen.main.bounds.size.width, height: 100);
        }
        
    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
    //
    //    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
    //
    //    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize.init(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        
        return CGSize.init(width: 0, height: 0)
    }

}
