//
//  CommunicationController.swift
//  RHT
//
//  Created by kamal on 5/15/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class CommunicationController: UIViewController,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var sbSearchMatter: UISearchBar!
    @IBOutlet weak var cvMatter: UICollectionView!
    var dataSource:MatterDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = MatterDataSource()
        cvMatter.dataSource = dataSource
        cvMatter.delegate = self
        cvMatter.reloadData()
        // Do any additional setup after loading the view.
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
