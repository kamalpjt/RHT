//
//  NewsCollectionViewCell.swift
//  RHT
//
//  Created by kamal on 04/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    func SetUpView(newsData:NewsPost) -> Void {
        setupShadow()
        lblHeader.text = newsData.title!
        lblDescription.text = newsData.description!
        lblDate.text = newsData.postdate!
        //        lblmattername.text = matterData.matterid
        //        lblSubName.text = matterData.name
        //        lblDescription.text = matterData.description
        
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
