//
//  MatterCollectionViewCell.swift
//  RHT
//
//  Created by vinoth on 16/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var vTop: UIView!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var lblmattername: UILabel!
    @IBOutlet weak var vImageView: UIView!
    @IBOutlet weak var vCorner: UIView!
    
    func SetUpView(matterData:matters) -> Void {
        setupShadow()
        lblmattername.text = matterData.matterid
        lblSubName.text = matterData.name
        lblDescription.text = matterData.description
        
    }
    private func setupShadow() {
        self.contentView.layer.cornerRadius = 10
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
