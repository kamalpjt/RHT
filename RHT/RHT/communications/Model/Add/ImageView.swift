//
//  ImageView.swift
//  RHT
//
//  Created by kamal on 07/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ImageView: NSObject,UICollectionViewDataSource {
    
    var stringImage:[UIImage]  = []

//    override init(frame: CGRect, collectionViewLayout collectionViewLayoutlayout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: collectionViewLayoutlayout)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
    
        let num = stringImage.count-1
        if num == indexPath.row {
            cell.backgroundColor = UIColor.lightGray
            cell.imgPlus.isHidden = false
            cell.imgCell.isHidden = true
            cell.butDelete.isHidden = true
        }else{
              cell.backgroundColor = UIColor.clear
            cell.imgCell.image = stringImage[indexPath.row]
            cell.imgCell.isHidden = false
            cell.imgPlus.isHidden = true
            cell.butDelete.isHidden = false
        }
        return cell;
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
