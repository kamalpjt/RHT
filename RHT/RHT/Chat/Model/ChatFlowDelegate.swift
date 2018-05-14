//
//  ChatFlowDelegate.swift
//  RHT
//
//  Created by vinoth on 12/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatFlowDelegate: NSObject,UICollectionViewDelegateFlowLayout {

    private var chatItem = [ChatData]()
    init(item:[ChatData]) {
        self.chatItem = item
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return   1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //check the postive value first
        if let messagetext = chatItem[indexPath.row].chatMessage{
            
            print(messagetext);
            let estimatedFramemessage = ShareData.sharedInstance.GetStringCGSize(stringValue: messagetext, font: UIFont.systemFont(ofSize: ShareData.SetFont13(), weight: UIFont.Weight.regular))
            
            let estimatedFramename = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.semibold))
            
             let estimatedFramedate = ShareData.sharedInstance.GetStringCGSize(stringValue:chatItem[indexPath.row].userName!, font:UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold))
            
              return CGSize.init(width: UIScreen.main.bounds.size.width, height: (estimatedFramemessage.height+estimatedFramedate.height+estimatedFramename.height+8));
        }else{
             return CGSize.init(width: UIScreen.main.bounds.size.width, height: 100);
        }
      
    }
    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//
//    }

//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//
//    }
    
   
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize.init(width: 0, height: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        
         return CGSize.init(width: 0, height: 0)
    }
}
