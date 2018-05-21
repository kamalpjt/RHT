//
//  DesignableTextView.swift
//  RHT
//
//  Created by kamal on 5/21/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
@IBDesignable
class DesignableTextView: UITextView {
    
    @IBInspectable var CornerRadius: CGFloat = 0
    override func draw(_ rect: CGRect) {
        
        addCorner(arcRadius: self.CornerRadius)
    }
    func addCorner(arcRadius: CGFloat) {
        let corner:UIRectCorner = [UIRectCorner.allCorners]
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corner , cornerRadii: CGSize(width: arcRadius, height: arcRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
