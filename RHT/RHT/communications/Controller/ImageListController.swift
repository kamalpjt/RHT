//
//  ImageListController.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ImageListController: UIViewController {
    
    var svImageList = UIScrollView()
    var vContainer = UIView()
    var m_PhotosArray:[String]?
    //MARK:- ViewcontrollerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddScrollview()
        setupConstraints()
        AddImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:Common Funcation
    func AddScrollview () -> Void {
        vContainer.translatesAutoresizingMaskIntoConstraints = false
        vContainer.backgroundColor = UIColor.white;
        svImageList.translatesAutoresizingMaskIntoConstraints = false;
        svImageList.showsVerticalScrollIndicator = false
        svImageList.showsHorizontalScrollIndicator = true;
        self.view.addSubview(vContainer)
        self.vContainer.addSubview(svImageList)
       
    }
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            let safeGuide = self.view.safeAreaLayoutGuide
            vContainer.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
            vContainer.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
            vContainer.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
            vContainer.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            vContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            vContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            vContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            vContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        svImageList.leadingAnchor.constraint(equalTo: vContainer.leadingAnchor).isActive = true
        svImageList.trailingAnchor.constraint(equalTo: vContainer.trailingAnchor).isActive = true
        svImageList.topAnchor.constraint(equalTo: vContainer.topAnchor).isActive = true
        svImageList.bottomAnchor.constraint(equalTo: vContainer.bottomAnchor).isActive = true
       
    }
    func AddImage() -> Void{
      //  let image = ["sample1","sample2","sample3","sample4","sample5"]
        let height =  UIScreen.main.bounds.size.height/2-64
        var yvalue  = 1
        for index in 0...(m_PhotosArray?.count)!-1 {
            print("\(index) times 5 is \(index * 5)")
            let view = UIView()
            view.frame = CGRect(x: 0, y: CGFloat(yvalue), width: UIScreen.main.bounds.size.width, height: height)
            
            let imageview = UIImageView()
            imageview.frame = CGRect(x: 5, y: CGFloat(5), width: UIScreen.main.bounds.size.width-10, height: height-5)
            print("sample"+String(index+1))
           // imageview.image = UIImage.init(named: "sample"+String(index+1))
            imageview.sd_setImage(with: URL(string: m_PhotosArray![index]), placeholderImage: UIImage(named: "placeholder"))
            
            view.addSubview(imageview)
            self.svImageList.addSubview(view)
            
            yvalue = yvalue + Int(height)
        }
        self.svImageList.contentSize = CGSize.init(width: Int(view.frame.width), height: yvalue)
    }
    //MARK:Action
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
