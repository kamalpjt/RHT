//
//  CustomText.swift
//  RHT
//
//  Created by kamal on 21/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
@IBDesignable
class Customtext:UITextField {
    
    @IBInspectable var CornerRadius: CGFloat = 0
//    @IBInspectable var roundCornerRadius:Bool = false {
//        didSet{
//            if(roundCornerRadius)
//            {
//                self.layer.cornerRadius = self.frame.height/2.0
//            }
//
//        }
//
//    }
//    @IBInspectable var CornerRadius:CGFloat = 0.0 {
//        didSet{
//
//            self.layer.cornerRadius = CornerRadius
//            self.layoutSubviews()
//        }
//    }
    let paddingsPlaceHolder = UIEdgeInsets(top: 0, left:40, bottom: 0, right: 10);
    let paddingsTextHolder = UIEdgeInsets(top: 0, left:40, bottom: 0, right: 10);
    override func draw(_ rect: CGRect) {
        
        if ShareData .isIpad(){
            font = UIFont.systemFont(ofSize: 20)
        }else{
            font = UIFont.systemFont(ofSize: 14)
        }
        
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
        //self.layer.cornerRadius = CornerRadius
        addCirle(arcRadius: CornerRadius)
    }
    func addCirle(arcRadius: CGFloat) {
        let corner:UIRectCorner = [UIRectCorner.allCorners]
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corner , cornerRadii: CGSize(width: arcRadius, height: arcRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
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
}
