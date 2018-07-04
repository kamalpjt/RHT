//
//  NewsDataSource.swift
//  RHT
//
//  Created by kamal on 04/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class NewsDataSource: NSObject,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    private let cellIdentifier = "NewsCollectionViewCell"
    public var m_matterPostDetail:[NewsPost]?
    public var m_matterTotalCount:Int?
    let m_pageNationDelgate:PageNationDelegate?
    init(delegate:PageNationDelegate) {
        m_pageNationDelgate = delegate
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (m_matterPostDetail?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! NewsCollectionViewCell
        let data = m_matterPostDetail?[indexPath.row]
        cell.SetUpView(newsData: data!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width-40, height: 70)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.y
        // print(scrollView.contentOffset.y)
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            if(m_matterTotalCount != m_matterPostDetail?.count)
            {
                print("Last row called")
                m_pageNationDelgate?.pageNationAction()
            }else{
                print("Last row completed")
            }
        }
    }

}
