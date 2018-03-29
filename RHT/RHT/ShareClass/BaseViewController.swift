//
//  BaseViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //SetBackGroundColor()
        // Do any additional setup after loading the view.
    }
    
    func  SetBackGroundColor(color: UIColor) -> Void {
        
        view.backgroundColor = color;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
