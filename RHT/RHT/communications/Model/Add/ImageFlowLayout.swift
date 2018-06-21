//
//  ImageFlowLayout.swift
//  RHT
//
//  Created by kamal on 21/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class ImageFlowLayout: UICollectionViewFlowLayout {
    
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
        sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    override var itemSize: CGSize {
        set {
            
        }
        get {
            //let numberOfColumns: CGFloat = 3
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width-20
            // let  screenHeight = screenSize.height
            
            //let itemWidth = (self.collectionView?.frame.width)!/2
        return CGSize(width: (screenWidth/3)-1, height: 115)
            
            
        }
    }
}
