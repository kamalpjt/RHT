//
//  CustomTextField.swift
//  RHT
//
//  Created by vinoth on 30/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
class CustomTextField: UITextField {
    let paddingsPlaceHolder = UIEdgeInsets(top: 0, left:40, bottom: 0, right: 10);
    let paddingsTextHolder = UIEdgeInsets(top: 0, left:40, bottom: 0, right: 10);
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
    override func draw(_ rect: CGRect) {
        if tag==1{
                let view = UIView();
                view.frame = CGRect(x:44, y: self.frame.height-1, width: rect.width-44, height:1)
                 view.backgroundColor = AppConstant.sharedInstance.textline;
                 self.addSubview(view)
        }else{
            let view = UIView();
            view.frame = CGRect(x:0, y: self.frame.height-1, width: rect.width, height:1)
            view.backgroundColor = AppConstant.sharedInstance.textline;
            self.addSubview(view)
        }
    }
   
    override func textRect(forBounds bounds: CGRect) -> CGRect {

        if tag == 1 {
            return UIEdgeInsetsInsetRect(bounds, paddingsTextHolder)
        }else{
             return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if tag==1{
            return UIEdgeInsetsInsetRect(bounds, paddingsTextHolder)
        }else{
            return UIEdgeInsetsInsetRect(bounds,UIEdgeInsetsMake(0, 0, 0, 0));
        }
        
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        if tag==1{
             return UIEdgeInsetsInsetRect(bounds, paddingsPlaceHolder)
        }else{
             return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 0, 0, 0))
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
