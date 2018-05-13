//
//  ChatCell.swift
//  RHT
//
//  Created by kamal on 5/11/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

struct ChatData {
    var chatMessage:String?
    var userName:String?
    var IsSender:Bool?
    var date:String?
}

class ChatCell: UICollectionViewCell {
    
    var lblUserName:UILabel = {
        let lblname = UILabel()
        lblname.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        lblname.text = "Userdfjhshdjfhjkhjfhdjskhjfhsdjhfjshdfjsk"
        lblname.translatesAutoresizingMaskIntoConstraints = false;
        lblname.textColor = UIColor.blue;
        return lblname;
    }()
    var tvChat:UITextView = {
        let txView = UITextView()
        txView.textContainerInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        txView.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        txView.text = "sampleMessage"
        txView.translatesAutoresizingMaskIntoConstraints = false;
        txView.backgroundColor = AppConstant.sharedInstance.backGroundColor;
        txView.textColor = UIColor.white
        txView.isEditable = false;
        txView.isScrollEnabled = false;
       // txView.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return txView;
    }()
    var lblDate:UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
        date.text = "12/09/2005"
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.textColor = UIColor.gray;
        return date;
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lblUserName)
        addSubview(tvChat)
        addSubview(lblDate)
       // contentView.backgroundColor = UIColor.lightGray
        SetUpLayout()
        
       // backgroundColor? = UIColor.red;
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
    public func BindValue(chatitem:ChatData)
    {
      
        UserNameHeight(messagetext: chatitem.chatMessage!, userName: chatitem.userName!, date: chatitem.date!)
        tvChat.text = chatitem.chatMessage
        lblUserName.text = chatitem.userName
        lblDate.text = chatitem.date
        tvChat.layer.cornerRadius = 15
        tvChat.layer.masksToBounds = true;
        lblUserName.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
        lblDate.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
        tvChat.textAlignment = chatitem.IsSender == true ?  NSTextAlignment.left :  NSTextAlignment.right;
        SetUpLayout()
        
        if(chatitem.IsSender!)
        {
            tvChat.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive=true
            tvChat.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive=false
        }else{
            tvChat.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive=false
            tvChat.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive=true
        }
        
    }
    private func UserNameHeight(messagetext: String,userName: String,date:String)
    {
        
        let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular))
        
        let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:userName, font:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold))
        
        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:date, font:UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold))
    
         tvChat.heightAnchor.constraint(equalToConstant:estimatedFramemessage.height).isActive=true
         tvChat.widthAnchor.constraint(equalToConstant: estimatedFramemessage.width).isActive=true
         lblUserName.heightAnchor.constraint(equalToConstant:estimatedFramename.height).isActive=true
         lblDate.heightAnchor.constraint(equalToConstant:estimatedFramedate.height).isActive=true
       // self.layoutIfNeeded()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
