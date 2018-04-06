//
//  SharedNavigation.swift
//  RHT
//
//  Created by vinoth on 06/04/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
extension UINavigationController{
}
class SharedNavigation:UINavigationController {
    static let sharedInstance = SharedNavigation()
    
    func menuButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setImage(UIImage.init(named: "menu"), for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(buttonAction(_:)) , for: UIControlEvents.touchUpInside)
        menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        menuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        menuButton.contentMode = UIViewContentMode.right
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
    }
}
