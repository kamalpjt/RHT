//
//  HomeViewController.swift
//  RHT
//
//  Created by vinoth on 31/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
struct ListMdoel {
    var name:String = ""
    var imageName:String =  ""
    
    
}

class HomeViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var CollectionModel:[String] = [];
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        var num = ShareData.sharedInstance.ChangeImageTintColor(imageName: "Logo")
         //num.frame = CGRect(x: -120, y: 0, width: ShareData.sharedInstance.ChangeImageTintColor(imageName: "Logo").frame.width, height: ShareData.sharedInstance.ChangeImageTintColor(imageName: "Logo").frame.height)
        //num.frame = navigationController?.view.frame.origin.
      //  num.contentMode = UIViewContentMode.scaleAspectFit
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = ShareData.sharedInstance.ChangeImageTintColor(imageName: "Logo").image
        self.navigationItem.titleView?.frame = CGRect(x: -400, y: 0, width: 50, height: 50)
         self.navigationItem.titleView = imageView
        homeCollectionView.delegate = self;
        homeCollectionView.dataSource = self;
        CollectionModel.append("ChatBhot")
        CollectionModel.append("Communications")
        CollectionModel.append("News")
        CollectionModel.append("Annonce")
        CollectionModel.append("File")
        CollectionModel.append("note")
       // navigationItem.leftBarButtonItems = [SharedNavigation.sharedInstance.menuButton()]
         navigationItem.leftBarButtonItems = [menuButton()]
        // Do any additional setup after loading the view.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionModel.count
    }
 
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        if ShareData.isIPhone5() {
//            return 140
//        }else if ShareData.isIPhone6() {
//            return 0
//        }else if ShareData.isIPhone6Plus(){
//            return 0
//        }else if ShareData.isIPhoneX(){
//            return 10
//        }else{
//            return 0
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            if ShareData.isIPhone5() {
//                 return CGSize(width: 150, height: 150);
//            }else if ShareData.isIPhone6() {
//                 return CGSize(width: 170, height: 150);
//            }else if ShareData.isIPhone6Plus(){
//                 return CGSize(width: 120, height: 100);
//            }else if ShareData.isIPhoneX(){
//                 return CGSize(width: 170, height: 150);
//            }else{
//                return CGSize(width: 180, height: 180);
//            }
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.imgCollection.image = UIImage.init(named: CollectionModel[indexPath.row]);

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    @IBAction func ChatButton(_ sender: Any) {
        
        
        let num =   self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(num, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
