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
//enum MessageType{
//    case image
//    case text
//}

class CommentCell: UITableViewCell {
    
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
    private let cellIdentifier = "ChatCell"
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
    public func BindValue(chatitem:CommetList)
    {
        tvChat.text = chatitem.comment!
        lblUserName.text = chatitem.sendername!
        lblDate.text = chatitem.createddate!
        tvChat.layer.cornerRadius = 15
        tvChat.layer.masksToBounds = true;
        lblUserName.textAlignment = NSTextAlignment.left;
        lblDate.textAlignment = NSTextAlignment.left;
        tvChat.textAlignment = NSTextAlignment.left;
        //  SetUpLayout()
        UserNameHeight(messagetext: chatitem.comment!, userName: chatitem.sendername!, date: chatitem.createddate!)
    }
    private func UserNameHeight(messagetext: String,userName: String,date:String)
    {
        
        let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
        
        let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:userName, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
        
        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:date, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
        
            lblUserName.frame = CGRect(x: 15, y: 5, width: ShareData.GetPhoneCurrentScreenWidth(), height: estimatedFramename.height)
            //top =10 ,bottom= 10 == 20
            tvChat.frame = CGRect(x: 5, y: lblUserName.frame.height+7, width: estimatedFramemessage.width+20, height: estimatedFramemessage.height+20)
            lblDate .frame = CGRect(x: 14, y: lblUserName.frame.height+tvChat.frame.height+8, width: ShareData.GetPhoneCurrentScreenWidth(), height: estimatedFramedate.height)
            
    
        
        
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
