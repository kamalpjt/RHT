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

class ChatCell: UITableViewCell {

//    var vContainerview:UIView = {
//          let view = UIView()
//        view.backgroundColor = UIColor.magenta
//        return view
//    }()
    var lblUserName:UILabel = {
        let lblname = UILabel()
        lblname.textAlignment = .left
        lblname.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold)
        lblname.text = "Userdfjhshdjfhjkhjfhdjskhjfhsdjhfjshdfjsk"
        lblname.translatesAutoresizingMaskIntoConstraints = false;
        lblname.textColor = UIColor.blue;
        return lblname;
    }()
    var tvChat:UITextView = {
        let txView = UITextView()
        //txView.textAlignment = .right
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
        date.textAlignment = .left
        date.font = UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold)
        date.text = "12/09/2005"
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.textColor = UIColor.gray;
        return date;
    }()
    private let cellIdentifier = "ChatCell"
    var item:ChatModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       //  self.SetUpLayout()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.selectionStyle = UITableViewCellSelectionStyle.none;
//        self.contentView.addSubview(vContainerview)
        self.contentView.backgroundColor = UIColor.yellow
        self.contentView.addSubview(lblDate)
        self.contentView.addSubview(lblUserName)
        self.contentView.addSubview(tvChat)
       
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        
    }

    private func SetUpLayout()
    {
//        lblUserName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive=true
//        lblUserName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
//        lblUserName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive=true
//        //if(IsSenders)
//        tvChat.topAnchor.constraint(equalTo: lblUserName.bottomAnchor, constant: 4).isActive=true;
//        lblDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive=true
//        lblDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive=true
//        lblDate.topAnchor.constraint(equalTo: tvChat.bottomAnchor, constant: 4).isActive=true;
    
    }
    override func layoutSubviews() {
        
        let getValueTuples = getSize(dateText: (item?.date!)!, messageText: (item?.chatMessage!)!, nameText: (item?.userName!)!)
        let dateSize = getValueTuples.0;
        let messageSize = getValueTuples.1;
        let nameSize = getValueTuples.2
        
        lblUserName.frame = CGRect(x: 5, y: 5, width: ShareData.GetPhoneCurrentScreenWidth(), height: nameSize.height)
        
        tvChat.frame = CGRect(x: 5, y: 17+7, width: messageSize.width+20, height: messageSize.height+20)
        
        lblDate .frame = CGRect(x: 14, y: lblUserName.frame.height+tvChat.frame.height+8, width: ShareData.GetPhoneCurrentScreenWidth(), height: dateSize.height)
        
        
        
        tvChat.text = item?.chatMessage!
        lblUserName.text = item?.userName!
        lblDate.text = item?.date!
        
    }
    func createUsernameLabel(username:String,messageRect:CGRect,dateRect:CGRect,nameRect:CGRect) -> UILabel {
        
        let lblname = UILabel()
        lblname.frame = CGRect(x:5, y: 5, width: ShareData.GetPhoneCurrentScreenWidth()-15, height: nameRect.height)
        lblname.textAlignment = .left
        lblname.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold)
        lblname.text = username
        //lblname.translatesAutoresizingMaskIntoConstraints = false;
        lblname.textColor = UIColor.brown;
        return lblname;
    }
    func createDateLabel(dateText:String,messageRect:CGRect,dateRect:CGRect,nameRect:CGRect) -> UILabel  {
        
//        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:dateText, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))

        let date = UILabel()
        let ypos = 5 + nameRect.height + 7 + messageRect.height+20 + 2
        date.frame = CGRect(x:5, y: ypos, width: ShareData.GetPhoneCurrentScreenWidth()-15, height: dateRect.height)
        date.textAlignment = .left
        date.font = UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold)
        date.text = dateText
       // date.translatesAutoresizingMaskIntoConstraints = false;
        date.textColor = UIColor.gray;
        return date;
    }
    func createMessageText(messagetext:String,messageRect:CGRect,dateRect:CGRect,nameRect:CGRect) -> UITextView {
        
        
//        let messageSize = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
        let txView = UITextView()
        txView.frame = CGRect(x: 5, y: (5+nameRect.height+7), width: messageRect.width+20, height: (messageRect.height+20))
        txView.textAlignment = .left
        txView.layer.cornerRadius = 15
        txView.layer.masksToBounds = true;
        txView.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        txView.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        txView.textContainer.lineFragmentPadding = 0
        txView.font = UIFont.systemFont(ofSize: ShareData.SetFont13() , weight: UIFont.Weight.regular)
        txView.text = messagetext
       // txView.translatesAutoresizingMaskIntoConstraints = false;
        txView.backgroundColor = AppConstant.sharedInstance.backGroundColor;
        txView.textColor = UIColor.white
        txView.isEditable = false;
        txView.isScrollEnabled = false;
        txView.dataDetectorTypes = UIDataDetectorTypes.all
        // txView.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return txView;
    }
    func getSize(dateText: String, messageText:String, nameText:String) -> (CGRect, CGRect, CGRect) {
        
        let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:nameText, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
        
        let messageSize = ShareData.sharedInstance.GetStringCGSize(stringValue: messageText, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
        
        let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:dateText, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
        
        return (estimatedFramedate, messageSize ,estimatedFramename)
    }
    public func BindValue(chatitem:ChatModel,row:Int)
    {
        item = chatitem
       
        
        
//        let totalHeight = messageSize.height+dateSize.height+nameSize.height+39;
//        let vContainerview = UIView()
//        vContainerview.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: totalHeight)
//        self.contentView.addSubview(vContainerview)
//        
//         vContainerview.addSubview(createUsernameLabel(username: chatitem.userName!, messageRect: messageSize, dateRect: dateSize, nameRect: nameSize))
//         vContainerview.addSubview(createMessageText(messagetext: chatitem.chatMessage!, messageRect: messageSize, dateRect: dateSize, nameRect: nameSize))
//        vContainerview.addSubview(createDateLabel(dateText: chatitem.date!, messageRect: messageSize, dateRect: dateSize, nameRect: nameSize))

    }
  /*  private func UserNameHeight(messagetext: String,userName: String,date:String, sendervalue:Bool)
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
    }*/
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
