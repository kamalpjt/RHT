//
//  LeaderCollectionCell.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import SDWebImage
class LeaderCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var imgPdf: UIImageView!
    
    func SetUpView(LeaderData:Leaderposts) -> Void {
        setupShadow()
        lblDescription.text = LeaderData.description;
        lbltitle.text = LeaderData.title
        imgPdf.sd_setImage(with: URL(string: LeaderData.imageurl!), placeholderImage: UIImage(named: "placeholder"))
//        var lineCount:Int = 0;
//        let textsize = CGSize.init(width: lblDescription.frame.size.width, height: CGFloat(MAXFLOAT))
//        let  rheight:Int = lroundf(Float(lblDescription.sizeThatFits(textsize).height));
//        let  charsize = lroundf(Float(lblDescription.font.lineHeight));
//        lineCount = rheight / charsize;
//        print(lineCount)
    }
    private func setupShadow() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
    }
}
