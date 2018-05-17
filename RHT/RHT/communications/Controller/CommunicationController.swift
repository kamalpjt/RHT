//
//  CommunicationController.swift
//  RHT
//
//  Created by kamal on 5/15/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class CommunicationController: UIViewController,UICollectionViewDelegate {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var sbSearchMatter: UISearchBar!
    @IBOutlet weak var cvMatter: UICollectionView!
    var dataSource:MatterDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetUpCollectionView()
        
    }
    func SetUpCollectionView()
    {
        self.dataSource = MatterDataSource()
        cvMatter.dataSource = dataSource
        cvMatter.delegate = self
        cvMatter.reloadData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//   {
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationController");
//    navigationController?.pushViewController(vc!, animated: true)
//   }
        
       
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
