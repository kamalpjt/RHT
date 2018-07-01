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
    let m_MatterModel:CommunicationModel?
    //public var chatItem = []()
     init(model:CommunicationModel) {
        m_MatterModel = model
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (m_MatterModel?.response.matters.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MatterCollectionViewCell
        cell.SetUpView(matterData: (m_MatterModel?.response.matters[indexPath.row])!)
       // cell.layer.cornerRadius = 10;
        //cell.layer.masksToBounds = false
        return cell;
    }
    

}
