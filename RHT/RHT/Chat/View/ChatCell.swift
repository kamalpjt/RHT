//
//  ChatCell.swift
//  RHT
//
//  Created by kamal on 5/11/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

//struct ChatData {
//    var chatMessage:String?
//    var userName:String?
//    var IsSender:Bool?
//    var date:String?
//    var mType:Int
//}
enum MessageType{
    case image
    case text
    case multiple
}

class ChatCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {

    var lblUserName:UILabel = {
        let lblname = UILabel()
        lblname.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold)
        lblname.text = "Userdfjhshdjfhjkhjfhdjskhjfhsdjhfjshdfjsk"
        lblname.translatesAutoresizingMaskIntoConstraints = false;
        lblname.textColor = UIColor.blue;
        return lblname;
    }()
    var tvChat:UITextView = {
        let txView = UITextView()
        txView.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        txView.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        txView.textContainer.lineFragmentPadding = 0
        txView.font = UIFont.systemFont(ofSize: ShareData.SetFont13() , weight: UIFont.Weight.regular)
        txView.text = "sampleMessage"
        txView.translatesAutoresizingMaskIntoConstraints = false;
        txView.backgroundColor = AppConstant.sharedInstance.backGroundColor;
        txView.textColor = UIColor.white
        txView.isEditable = false;
        txView.isScrollEnabled = false;
        txView.dataDetectorTypes = UIDataDetectorTypes.all
       // txView.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return txView;
    }()
    var lblDate:UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold)
        date.text = "12/09/2005"
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.textColor = UIColor.gray;
        return date;
    }()
    
    var tblView:UITableView = {
        let tbl = UITableView()
        return tbl
    }()
    private let cellIdentifier = "ChatCell"
    var textArray:[[String:AnyObject]] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       //  self.SetUpLayout()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(lblUserName)
        self.addSubview(tvChat)
        self.addSubview(lblDate)
        self.addSubview(tblView)
        self.selectionStyle = UITableViewCellSelectionStyle.none;
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func SetUpLayout()
    {
        lblUserName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive=true
        lblUserName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        lblUserName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive=true
        //if(IsSenders)
        tvChat.topAnchor.constraint(equalTo: lblUserName.bottomAnchor, constant: 4).isActive=true;
        lblDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive=true
        lblDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
        lblDate.topAnchor.constraint(equalTo: tvChat.bottomAnchor, constant: 4).isActive=true;
    
    }
    public func BindValue(chatitem:ChatModel)
    {
        tvChat.text = chatitem.chatMessage
        lblUserName.text = chatitem.userName
        lblDate.text = chatitem.date
        tvChat.layer.cornerRadius = 15
        tvChat.layer.masksToBounds = true;
        lblUserName.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
        lblDate.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
        tvChat.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
      //  SetUpLayout()
        if(chatitem.mType == MessageType.text)
        {
            UserNameHeight(messagetext: chatitem.chatMessage!, userName: chatitem.userName!, date: chatitem.date!, sendervalue: chatitem.IsSender!)
            
        }else if (chatitem.mType == MessageType.multiple){
            tblView.frame  = CGRect(x: 0, y: 5, width: Int(ShareData.GetPhoneCurrentScreenWidth() - 100), height: 44 * textArray.count)
            textArray = chatitem.textArray
            tblView.delegate = self
            tblView.dataSource = self
            tblView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return textArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(44 * textArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        let item = textArray[indexPath.row]
        cell.textLabel?.text =  item["title"] as? String
        return cell
    }
    private func UserNameHeight(messagetext: String,userName: String,date:String, sendervalue:Bool)
    {
        
        let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
        
        let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:userName, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
        
        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:date, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
        if(sendervalue)
        {
            lblUserName.frame = CGRect(x: 15, y: 5, width: ShareData.GetPhoneCurrentScreenWidth(), height: estimatedFramename.height)
            //top =10 ,bottom= 10 == 20
            tvChat.frame = CGRect(x: 5, y: lblUserName.frame.height+7, width: estimatedFramemessage.width+20, height: estimatedFramemessage.height+20)
            lblDate .frame = CGRect(x: 14, y: lblUserName.frame.height+tvChat.frame.height+8, width: ShareData.GetPhoneCurrentScreenWidth(), height: estimatedFramedate.height)

        }else{
            lblUserName.frame = CGRect(x:0, y: 5, width: ShareData.GetPhoneCurrentScreenWidth()-15, height: estimatedFramename.height)
            tvChat.frame = CGRect(x: UIScreen.main.bounds.width-25-estimatedFramemessage.width, y: lblUserName.frame.height+7, width: estimatedFramemessage.width+20, height: estimatedFramemessage.height+20)
            lblDate .frame = CGRect(x: 0, y: lblUserName.frame.height+tvChat.frame.height+8, width: ShareData.GetPhoneCurrentScreenWidth()-15, height: estimatedFramedate.height)
        }
       
        
          print("height:" + String(describing: estimatedFramemessage.height))
        
        //tvChat.frame = CGRect(x: 10, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    
        
//        SetUpLayout()
//         tvChat.heightAnchor.constraint(equalToConstant:estimatedFramemessage.height).isActive=true
//         tvChat.widthAnchor.constraint(equalToConstant: estimatedFramemessage.width).isActive=true
//        print("height:" + String(describing: estimatedFramemessage.height))
//         lblUserName.heightAnchor.constraint(equalToConstant:estimatedFramename.height).isActive=true
//         lblDate.heightAnchor.constraint(equalToConstant:estimatedFramedate.height).isActive=true
//        self.layoutIfNeeded()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
