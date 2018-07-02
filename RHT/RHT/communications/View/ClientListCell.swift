//
//  ClientListCell.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ClientListCell: UICollectionViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    func SetUpView(matterData:Userlist) -> Void {
        setupShadow()
        lblName.text = matterData.name!
        lblEmail.text = matterData.email!
//        lblmattername.text = matterData.matterid
//        lblSubName.text = matterData.name
//        lblDescription.text = matterData.description
        
    }
    private func setupShadow() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
    }
}
