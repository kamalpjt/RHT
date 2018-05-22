//
//  DesignableView.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
    
    @IBInspectable var CornerRadius: CGFloat = 0
    override func draw(_ rect: CGRect) {
        addCirle(arcRadius: CornerRadius)
    }
    func addCirle(arcRadius: CGFloat) {
        let corner:UIRectCorner = [UIRectCorner.allCorners]
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corner , cornerRadii: CGSize(width: arcRadius, height: arcRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
