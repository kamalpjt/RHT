//
//  AddCommunicationController.swift
//  RHT
//
//  Created by kamal on 21/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class AddCommunicationController: UIViewController,UICollectionViewDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var tvDescription: DesignableTextView!
    @IBOutlet weak var txtTittle: CustomTextField!
    var dataSourceImage = ImageView()
    var matterType:String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        // let imageCollectionView = ImageView()
        
        
        
        // imgCollectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageViewCell")
        dataSourceImage.stringImage = [#imageLiteral(resourceName: "PluseWhite")]
        imgCollectionView.dataSource = dataSourceImage
        imgCollectionView.delegate = self
        imgCollectionView.reloadData()
        navigationItem.rightBarButtonItems = [SubmitButton()]
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validation() -> Bool{
        
        if txtTittle.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtTittle.becomeFirstResponder()
            return false
        }else if tvDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            tvDescription.becomeFirstResponder()
            return false
        }else{
            return true
        }
    }
    //MARK:Action
    func SubmitButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setTitle("Submit", for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(SubmitAction), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    
    @objc func SubmitAction() -> Void{
        
        if validation() {
            let params:[String:Any] = ["title":txtTittle.text!,"content":tvDescription.text!
                ,"photos":[],"attachment":[],"postType":matterType,"matterId":"","receiverId":"","userType":UserDetail.Instance.user_type ?? 0,"id":UserDetail.Instance.id ?? ""]
            CommunicationParsing.instance.getResponseDetail(url: "/postcommunication", param: params, resposneBlock: { response , statuscode in
                if(statuscode == 200){
                    let model = response as! AddModel
                    self.tvDescription.text = ""
                    self.txtTittle.text = ""
                    SharedAlert.instance.ShowAlert(title: "Message", message: model.response.msg!, viewController: self)
                }
            })
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let controller  = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
     
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           dataSourceImage.stringImage.append(pickedImage)
            imgCollectionView.reloadData()
              self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
