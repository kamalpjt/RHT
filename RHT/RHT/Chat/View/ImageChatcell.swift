//
//  ImageChatcell.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ImageChatcell: UITableViewCell {

    var imageBackGroundView:UIView = {
    let view = UIView()
    view.backgroundColor = AppConstant.sharedInstance.backGroundColor
        view.layer.cornerRadius = 5
        return view
    }()
    let imageview:UIImageView = {
        let view = UIImageView()
        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func BindValue(item:ChatModel){
        if(item.IsSender!){
            imageBackGroundView.frame = CGRect(x: 10, y: 5, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2-5)
        }else{
            imageBackGroundView.frame = CGRect(x: UIScreen.main.bounds.size.width/2-10, y:5 , width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2-5)
        }
        addSubview(imageBackGroundView)
        imageview.image = UIImage.init(named: item.imageUrl!)
        imageview.contentMode = UIViewContentMode.scaleToFill
        imageview.frame = CGRect(x: 5, y: 5, width: UIScreen.main.bounds.size.width/2-10, height: UIScreen.main.bounds.size.width/2-15)
        imageBackGroundView.addSubview(imageview)
    }

}
