//
//  AddCommunicationController.swift
//  RHT
//
//  Created by kamal on 21/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import AWSS3
import Photos

class AddCommunicationController: BaseViewController,UICollectionViewDelegateFlowLayout ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AwsDelegate,AwsDelete{
    
    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var cvHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var vPDFBottomConstriants: NSLayoutConstraint!
    @IBOutlet weak var tvDescription: DesignableTextView!
    @IBOutlet weak var txtTittle: CustomTextField!
    var dataSourceImage = ImageView()
    var matterType:String = "";
    var selectedImageUrl: NSURL!
    var m_selectedImage: UIImage!
    var m_selectedImageUrlArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // let imageCollectionView = ImageView()
        
        
        
        // imgCollectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageViewCell")
        dataSourceImage.getDelegate(awsDelete: self)
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
        
        if(checkInternetIsAvailable()){
            if validation() {
                let params:[String:Any] = ["title":txtTittle.text!,"content":tvDescription.text!
                    ,"photos":m_selectedImageUrlArray,"attachment":[],"postType":matterType,"matterId":"","receiverId":"","userType":UserDetail.Instance.user_type ?? 0,"id":UserDetail.Instance.id ?? ""]
                CommunicationParsing.instance.getResponseDetail(url: "/postcommunication", param: params, resposneBlock: { response , statuscode in
                    if(statuscode == 200){
                        let model = response as! AddModel
                        self.tvDescription.text = ""
                        self.txtTittle.text = ""
                        self.m_selectedImageUrlArray.removeAll()
                        self.dataSourceImage.stringImage.removeAll()
                        self.dataSourceImage.stringImage = [#imageLiteral(resourceName: "PluseWhite")]
                        self.imgCollectionView.reloadData()
                        SharedAlert.instance.ShowAlert(title: "Message", message: model.response.msg!, viewController: self)
                    }
                })
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if(checkInternetIsAvailable()){
            if  dataSourceImage.stringImage.count <= 6 {
                let num = dataSourceImage.stringImage.count-1
                if num == indexPath.row {
                    let controller  = UIImagePickerController()
                    controller.delegate = self
                    controller.sourceType = .photoLibrary
                    present(controller, animated: true, completion: nil)
                }
                
            }
        }
        
        
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
            selectedImageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
            // getLocalImageFileName();
            
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                m_selectedImage = pickedImage
                let aws = AwsImage.init(selectedImageUrl: selectedImageUrl, selectedImage: pickedImage,contentType:AppConstant.sharedInstance.CONTENTTYPEIMAGE,
                                        S3BucketName:AppConstant.sharedInstance.IMAGEBUCKETNAME ,delegate: self)
                aws.getLocalImageFileName()
                self.dismiss(animated: true, completion: nil)
                
            }
        
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func getAwsUrl(url: NSURL) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            print(self.m_selectedImageUrlArray.append(url.absoluteString!))
            self.m_selectedImageUrlArray.append(url.absoluteString!)
            self.dataSourceImage.stringImage.insert( self.m_selectedImage, at: 0)
            if  self.dataSourceImage.stringImage.count > 3 {
                self.vPDFBottomConstriants.constant = self.view.frame.height-44 + 115
                self.cvHeightConstriant.constant = 235
                 self.svMain.contentSize =  CGSize(width: self.view.frame.width, height: self.vPDFBottomConstriants.constant)
            }else{
                // self.cvHeightConstriant.constant = 115
                // self.vPDFBottomConstriants.constant = self.view.frame.height - 115
            }
            self.imgCollectionView.reloadData()
           
        })
    }
    func getTagValue(tagValue: Int) {
        
        let stringUrl = self.m_selectedImageUrlArray[0];
        // let fullName : String = "First Last"
        let getImageName : [String] = stringUrl.components(separatedBy: "/")
        DeleteAwsImage.instance.DeleteImage(imageName: getImageName[getImageName.count-1])
        m_selectedImageUrlArray.remove(at: tagValue)
        dataSourceImage.stringImage.remove(at: tagValue)
        // let indexpath = IndexPath.init(row: tagValue, section: 0)
        // self.imgCollectionView.deleteItems(at: [indexpath])
        self.imgCollectionView.reloadData()
        if  self.dataSourceImage.stringImage.count < 3 {
             self.cvHeightConstriant.constant = 115
             self.vPDFBottomConstriants.constant = self.view.frame.height - 115
        }
        
    }
}
