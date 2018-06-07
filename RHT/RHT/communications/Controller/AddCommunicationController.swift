//
//  AddCommunicationController.swift
//  RHT
//
//  Created by kamal on 21/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class AddCommunicationController: UIViewController {

   
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    var dataSourceImage = ImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // let imageCollectionView = ImageView()
        
      
    
       // imgCollectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageViewCell")
        dataSourceImage.stringImage = [#imageLiteral(resourceName: "PluseWhite")]
        imgCollectionView.dataSource = dataSourceImage
       imgCollectionView.reloadData()
      navigationItem.rightBarButtonItems = [SubmitButton()]
        // Do any additional setup after loading the view.
    }
    func SubmitButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setTitle("Submit", for: UIControlState.normal)
         menuButton.addTarget(self, action:#selector(SubmitAction), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    @objc func SubmitAction() -> Void{
        
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
