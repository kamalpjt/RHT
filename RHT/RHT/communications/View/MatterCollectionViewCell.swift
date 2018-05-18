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
    
    @IBOutlet weak var vImageView: UIView!
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
        vImageView.layer.cornerRadius = 15;
        let path = UIBezierPath(roundedRect:vImageView.frame,byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 15, height:  vImageView.frame.height))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
       // vImageView.layer.mask = maskLayer
    //  setupShadow()
       //self.layer.masksToBounds = false;
        
    }
    private func setupShadow() {
        vTop.layer.shadowColor = UIColor.black.cgColor
        vTop.layer.shadowOffset = CGSize(width: 15.0, height: 20.0)
        vTop.layer.shadowOpacity = 0.3;
        vTop.layer.masksToBounds = false;
       
    }
}
