//
//  MatterDataSource.swift
//  RHT
//
//  Created by vinoth on 16/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterDataSource: NSObject,UICollectionViewDataSource {
    
    private let cellIdentifier = "MatterCell"
    //public var chatItem = []()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MatterCollectionViewCell
        cell.SetUpView()
       // cell.layer.cornerRadius = 10;
        //cell.layer.masksToBounds = false
        return cell;
    }
    

}
