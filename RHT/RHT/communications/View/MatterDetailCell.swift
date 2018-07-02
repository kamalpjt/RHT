//
//  MatterDetailCell.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import SDWebImage
class MatterDetailCell: UITableViewCell {
    
    @IBOutlet weak var vimages: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDocument: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgcontent: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var vMoreDetail: UIView!
    @IBOutlet weak var vContainer: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    func SetUpView(postData:Post)
    {
        vContainer.layer.cornerRadius = 5;
        vContainer.backgroundColor = UIColor.white
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        lblName.text = postData.sendername
        lbltitle.text = postData.title
        lblDescription.text = postData.content ?? ""
        lblDate.text = postData.createddate
        lblComment.text = String(postData.unreadcount!) + " " + "comment"
        if(postData.attachment != nil){
            let counts  = postData.attachment?.count
            lblDocument.text = String(counts!) + " " + "Attachment"
        }else{
            lblDocument.text = String(0) + " " + "Attachment"
        }
        if(postData.photos != nil){
            let countValue = (postData.photos?.count)!
            if(countValue==1)
            {
                
                vimages.isHidden = false
                vMoreDetail.isHidden = true
                let imageurl = postData.photos![0]
                imgcontent.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "placeholder"))
            }else if ((postData.photos?.count)! > 1){
                vMoreDetail.isHidden = true
                vimages.isHidden = false
                let imageurl = postData.photos![0]
                imgcontent.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "placeholder"))
            }else{
                vimages.isHidden = false
                vMoreDetail.isHidden = true
                imgcontent.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "placeholder"))
            }
        }else{
            vimages.isHidden = false
            vMoreDetail.isHidden = true
            imgcontent.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    @IBAction func CommentButtonAction(_ sender: Any) {
        
       NotificationCenter.default.post(name: Notification.Name(AppConstant.sharedInstance.commentListAction), object: nil, userInfo: ["Sender":sender])
        
    }
   
    @IBAction func MoreButtonAction(_ sender: Any) {
         NotificationCenter.default.post(name: Notification.Name("CommentAction"), object: nil, userInfo: ["Sender":sender])
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
        
    }
}

