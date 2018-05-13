//
//  ChatSource.swift
//  RHT
//
//  Created by kamal on 5/11/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatSource: NSObject,UICollectionViewDataSource {
    private let cellIdentifier = "ChatCell"
    private var chatItem = [ChatData]()
    
     init(item:[ChatData]) {

        self.chatItem = item
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chatItem.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ChatCell;
        let item  = self.chatItem[indexPath.row];
        cell.BindValue(chatitem: item)
        return cell;
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 50);
    }
    

}
