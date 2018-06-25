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
    @IBOutlet weak var butChat: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var CollectionModel:[String] = [];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTittleView()
        ConfigureColectionView()
        // navigationItem.leftBarButtonItems = [SharedNavigation.sharedInstance.menuButton()]
        navigationItem.leftBarButtonItems = [menuButton()]
        NotificationCenter.default.addObserver(self, selector: #selector(self.SettingSelectedAction(notification:)), name: Notification.Name(AppConstant.sharedInstance.SELECTEDINDEXPATH), object: nil)
       //butChat.layer.cornerRadius = 25
      //  butChat.layer.masksToBounds = false
        // Do any additional setup after loading the view.
        
    }
    func setTittleView()
    {
        let view = UIView()
        view.frame = CGRect(x: UIScreen.main.bounds.width/2, y: 0, width: 64, height: 64)
        view.backgroundColor = UIColor.clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: -5, width: 64, height: 50))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = ShareData.sharedInstance.ChangeImageTintColor(imageName: "Logo").image
        view.addSubview(imageView)
        self.navigationItem.titleView?.frame = CGRect(x: -400, y: 0, width: 50, height: 50)
        self.navigationItem.titleView = view
//        if ShareData.isIPhone5() {
//            butChat.layer.cornerRadius = butChat.layer.frame.height/8.0;
//        }
        
    }
    
    func ConfigureColectionView()
    {
        setTittleView()
        homeCollectionView.delegate = self;
        homeCollectionView.dataSource = self;
      //  CollectionModel.append("ChatBhot")
        CollectionModel.append("Communications")
        CollectionModel.append("News")
        CollectionModel.append("Annonce")
        CollectionModel.append("File")
        CollectionModel.append("note")
        
    }
    // MARK: -DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.imgCollection.image = UIImage.init(named: CollectionModel[indexPath.row]);
        return cell
        
    }
    // MARK: -Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = CollectionModel[indexPath.row]
        if  name == "Communications" {
            let storyboardLogin:UIStoryboard = UIStoryboard(name: "Communication", bundle: nil)
            let VC1 = storyboardLogin.instantiateViewController(withIdentifier: "CommunicationController") as! CommunicationController
            self.navigationController?.pushViewController(VC1, animated: true)
        }
    }
    // MARK: - ACTION
    @IBAction func ChatButton(_ sender: Any) {
        
        let num =   self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(num, animated: true)
        
    }
    @objc func SettingSelectedAction(notification: Notification){
       
        let userInfo = notification.userInfo
        let index = userInfo!["Indexpath"] as! Int
        if index == 0 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordController") as! ChangePasswordController
            self.navigationController?.pushViewController(VC, animated: true)
        }
        print(index)
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
