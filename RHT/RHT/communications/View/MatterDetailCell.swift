//
//  MatterDetailCell.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class MatterDetailCell: UITableViewCell {
    
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
    
    func SetUpView()
    {
        vContainer.layer.cornerRadius = 5;
        vContainer.backgroundColor = UIColor.white
        self.selectionStyle = UITableViewCellSelectionStyle.none;
       // lblComment.addGestureRecognizer(tapCommentTap)
    }
    @IBAction func CommentButtonAction(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name("CommentAction"), object: nil, userInfo: ["Sender":sender])
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
        
    }
}

