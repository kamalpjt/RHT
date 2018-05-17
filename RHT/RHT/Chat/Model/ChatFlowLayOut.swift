//
//  ChatFlowLayOut.swift
//  RHT
//
//  Created by kamal on 5/11/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChatFlowLayOut:UICollectionViewFlowLayout {
    
//https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html
    override init() {
         super.init()
    }
  
    override var itemSize: CGSize {
        set {
        }
        get {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            return CGSize(width: screenWidth, height: 50)
        }
    }
    
    override var minimumLineSpacing: CGFloat{
        set{
            
        }get{
            return 10;
        }
    }
    override var headerReferenceSize: CGSize{
        set{
          
        }get{
            return CGSize.init(width: 0, height: 0)
        }
    }
    override var footerReferenceSize: CGSize{
        set{
            
        }get{
            return CGSize.init(width: 0, height: 0)
        }
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    
}
