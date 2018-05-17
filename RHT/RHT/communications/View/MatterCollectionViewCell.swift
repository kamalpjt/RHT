//
//  MatterCollectionViewCell.swift
//  RHT
//
//  Created by vinoth on 16/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vCorner: UIView!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//       // self.backgroundColor = UIColor.orange
//
//       // vCorner.layer.cornerRadius = 5;
//        //vCorner.layer.masksToBounds = false;
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func SetUpView() -> Void {
        vCorner.layer.cornerRadius = 15;
        vCorner.layer.masksToBounds = false;
        
      setupShadow()
       //self.layer.masksToBounds = false;
        
    }
    private func setupShadow() {
        self.layer.cornerRadius = 15
        self.layer.shadowOffset = CGSize(width: self.frame.width, height: self.frame.height)
        self.layer.shadowRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
       // self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = false;
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
