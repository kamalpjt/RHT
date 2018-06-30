//
//  CommunicationController.swift
//  RHT
//
//  Created by kamal on 5/15/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class CommunicationController: UIViewController,UICollectionViewDelegate {
    @IBOutlet weak var vImageView: UIView!
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var sbSearchMatter: UISearchBar!
    @IBOutlet weak var cvMatter: UICollectionView!
    var dataSource:MatterDataSource?

    @IBOutlet weak var vContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vTop.layer.cornerRadius = 15;
        sbSearchMatter.layer.cornerRadius = 15;
        sbSearchMatter.layer.masksToBounds = false
        if UserDetail.Instance.isStaff != 1{
            vTop.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: 0.1/vContainer.frame.height , constant: 0).isActive=true
        }else{
              vTop.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: 44/vContainer.frame.height , constant: 0).isActive=true
        }
        
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
    
    @IBAction func generalAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationDetailController") as! CommunicationDetailController ;
        vc.matterType = "Gerenal";
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
   {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationDetailController") as! CommunicationDetailController ;
      vc.matterType = "matters";
      navigationController?.pushViewController(vc, animated: true)
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
