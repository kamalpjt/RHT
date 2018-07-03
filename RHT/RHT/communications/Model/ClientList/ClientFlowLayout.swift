//
//  ClientFlowLayout.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ClientFlowLayout: UICollectionViewFlowLayout {

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
            if !ShareData.isIpad(){
                return CGSize(width: (screenWidth)-16, height: 70)
            }else{
                return CGSize(width: (screenWidth/2)-16, height: 100)
                // return CGSize(width: (screenWidth)-16, height: 100)
            }
            
        }
        
    }
}
