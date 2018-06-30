//
//  HomeCollectionFlowLayout.swift
//  RHT
//
//  Created by vinoth on 07/04/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class HomeCollectionFlowLayout: UICollectionViewFlowLayout {
    
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 20
        scrollDirection = .vertical
        //to set top padding
        sectionInset =  UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
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
           // let leftpadding = 5;
           // let rightPadding = 5
            
            if ShareData.isIpad(){
                 return CGSize(width: (screenWidth/3)-30, height: (screenWidth/3)-30)
            }else{
                 return CGSize(width: (screenWidth/2)-30, height: (screenWidth/2)-30)
            }
           
        }
    }

}
