//
//  SharedData.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import UIKit

extension ShareData {
    class func isIPhone5 () -> Bool{
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 568.0
    }
    class func isIPhone6 () -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 667.0
    }
    class func isIPhone6Plus () -> Bool {
        return max(UIScreen.main.bounds.width,     UIScreen.main.bounds.height) == 736.0
    }
    class func isIPhoneX () -> Bool {
        return max(UIScreen.main.bounds.width,     UIScreen.main.bounds.height) == 812.0
    }
    class func isIpad () -> Bool {
        if UIDevice.current.model.hasPrefix("iPad") == true {
          return true;
        }else{
        return false;
       }
   }
}
class ShareData {
    
    
    static let sharedInstance = ShareData()
    
    func SetCornerRadius(view:UIView ,radius:CGFloat) -> Void {
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = true;
        //return view;
    }
    func SetCornerRadiusButton(view:UIButton ,radius:CGFloat) -> Void {
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = true;
        //return view;
    }
    
    func SetCornerRaiusForLeftandRight(view:UIView ,radius:CGFloat) -> Void {
        
        let path = UIBezierPath(roundedRect:view.bounds,byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: radius, height:  radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    func UnderLineText(text: String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString;
    }
    func DrawBorder(view: UIView , color:UIColor) -> Void {
        view.layer.borderColor = color.cgColor;
        view.layer.borderWidth = 1;
        
    }
}
