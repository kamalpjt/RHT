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
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
        //to set top padding
        sectionInset =  UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 0)
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
            if ShareData.isIpad(){
                 return CGSize(width: (screenWidth/3)-6, height: (screenWidth/3)-6)
            }else{
                 return CGSize(width: (screenWidth/2)-6, height: (screenWidth/2)-6)
            }
           
        }
    }

}
