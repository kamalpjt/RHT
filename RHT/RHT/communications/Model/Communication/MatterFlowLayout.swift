//
//  MatterFlowLayout.swift
//  RHT
//
//  Created by vinoth on 16/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    func setupLayout() {
        if(!ShareData.isIpad())
        {
            minimumInteritemSpacing = 1
            minimumLineSpacing = 10
            scrollDirection = .vertical
            //to set top padding
            sectionInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }else{
            minimumInteritemSpacing = 1
            minimumLineSpacing = 10
            scrollDirection = .vertical
            //to set top padding
            sectionInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        }
       
    }
    override var itemSize: CGSize {
        set {
            
        }
        get {
            //let numberOfColumns: CGFloat = 3
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            // let  screenHeight = screenSize.height
            
            //let itemWidth = (self.collectionView?.frame.width)!/2
            if !ShareData.isIpad(){
                return CGSize(width: (screenWidth)-16, height: (self.collectionView?.frame.height)!/5)
            }else{
                return CGSize(width: (screenWidth/2)-16, height: 100)
                // return CGSize(width: (screenWidth)-16, height: 100)
            }
            
        }
        
    }
}
