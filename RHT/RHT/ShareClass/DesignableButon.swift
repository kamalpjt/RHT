//
//  DesignableButon.swift
//  RHT
//
//  Created by kamal on 18/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButon: UIButton {

    @IBInspectable var roundCornerRadius:Bool = false {
        didSet{
            if(roundCornerRadius)
            {
                     self.layer.cornerRadius = self.frame.height/2.0
            }
            
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
