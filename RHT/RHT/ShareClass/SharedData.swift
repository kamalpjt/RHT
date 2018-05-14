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
    class func SetFont14()-> CGFloat {
        if(!isIpad())
        {
            return 14
        }else{
            return 20
        }
    }
    class func SetFont13()-> CGFloat {
        if(!isIpad())
        {
            return 13
        }else{
            return 19
        }
    }
    class func SetFont12()-> CGFloat {
        if(!isIpad())
        {
            return 12
        }else{
            return 18
        }
    }
    class func GetPhoneCurrentScreenWidth()-> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    class func GetPhoneCurrentScreenHeight()-> CGFloat {
        return UIScreen.main.bounds.size.height
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
    
    func GetStringCGSize(stringValue:String,font:UIFont) -> CGRect {
        
      //  let size =  CGSize.init(width: UIScreen.main.bounds.size.width, height: 999999)
        let size  = CGSize.init(width: UIScreen.main.bounds.size.width-90, height: 1000)
        //let size = CGSize(UIScreen.main.bounds.size.width, 999999)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedStringSize = NSString(string: stringValue).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : font ], context: nil)
        
        return estimatedStringSize
    }
}
