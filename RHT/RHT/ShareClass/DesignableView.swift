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
    
    @IBInspectable var roundCornerRadius:Bool = false {
        didSet{
            if(roundCornerRadius)
            {
                self.layer.cornerRadius = self.frame.height/2.0
            }
            
        }
        
    }
    @IBInspectable var CornerRadius:CGFloat = 0.0 {
        didSet{
            
                self.layer.cornerRadius = CornerRadius
        
            
        }
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
