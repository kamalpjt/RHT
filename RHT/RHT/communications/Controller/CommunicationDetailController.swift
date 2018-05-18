//
//  CommunicationDetailController.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit



class CommunicationDetailController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var tblmatterDetail: UITableView!
      private let cellIdentifier = "MatterCell"
   // var cell:MatterDetailCell?
    var dataSource:MatterDetailDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        tblmatterDetail.estimatedRowHeight = 50;
        self.dataSource = MatterDetailDataSource()
        //tblmatterDetail.register(MatterDetailCell.self, forCellReuseIdentifier: cellIdentifier)
        tblmatterDetail.dataSource = dataSource
        tblmatterDetail.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableViewViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return UITableViewAutomaticDimension
    }

}
