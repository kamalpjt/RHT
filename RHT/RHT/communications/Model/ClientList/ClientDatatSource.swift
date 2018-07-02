//
//  ClientDatatSource.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
protocol GetIDDelegate {
    func GetSelectedRecevierId(receverid:String)
}
class ClientDatatSource: NSObject,UICollectionViewDataSource,UICollectionViewDelegate {

    private let cellIdentifier = "ClientListCell"
    let m_MatterModel:ClientModel?
    var m_delegate:GetIDDelegate?
    //public var chatItem = []()
    init(model:ClientModel,delegate:GetIDDelegate) {
        m_MatterModel = model
        m_delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (m_MatterModel?.response.userlist.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ClientListCell
        cell.SetUpView(matterData: (m_MatterModel?.response.userlist[indexPath.row])!)
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = m_MatterModel?.response.userlist[indexPath.row]
        m_delegate?.GetSelectedRecevierId(receverid: (model?.id!)!)
    }
}
