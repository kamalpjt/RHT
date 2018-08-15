//
//  tableCell.swift
//  RHT
//
//  Created by kamal on 8/14/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class tableCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
//    var tblView:UITableView = {
//        let tbl = UITableView()
//        tbl.backgroundColor = UIColor.lightGray
//        tbl.translatesAutoresizingMaskIntoConstraints = false;
//        return tbl
//    }()
    var lblDate:UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: ShareData.SetFont12(), weight: UIFont.Weight.semibold)
        date.text = "12/09/2005"
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.textColor = UIColor.gray;
        return date;
    }()
    var lblView:UIView = {
        let lblv = UIView()
        lblv.backgroundColor = UIColor.brown
        lblv.translatesAutoresizingMaskIntoConstraints = false;
        return lblv
    }()
    var textArray:[[String:AnyObject]] = []
    var headerHeight:Int?
     var headerText:String?
    //  private let cellIdentifier = "tableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        //        self.addSubview(tblView)
        
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // self.addSubview(tblView)
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        // self.addSubview(lblView)
        self.addSubview(lblView)
        // self.backgroundColor = UIColor.red
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func BindValue(chatitem:ChatModel,tag:Int)
    {
        //debugPrint()
        textArray = chatitem.textArray
        let num = textArray.count * 44 + 44 + 5
        let size = ShareData.sharedInstance.GetchatStringCGSize(stringValue:chatitem.multipleHeaderText! , font: UIFont.systemFont(ofSize: 14, weight: .semibold), width: Int(ShareData.GetPhoneCurrentScreenWidth() - 100))
        headerHeight = Int(size.height)
        headerText = chatitem.multipleHeaderText
        debugPrint(num)
        lblView.frame  = CGRect(x: 5, y: 5, width: Int(ShareData.GetPhoneCurrentScreenWidth() - 100), height: num)
        ShareData.sharedInstance.DrawBorder(view: lblView, color: UIColor.lightGray)
        lblView.backgroundColor = UIColor.brown
        lblView.layer.cornerRadius = 5;
        lblView.layer.masksToBounds = true;
        let tblView = UITableView()
        tblView.tag = tag
        tblView.isScrollEnabled = false
        lblView.addSubview(tblView)
        tblView.frame  = CGRect(x: 0, y: 0, width: lblView.frame.size.width, height: lblView.frame.size.height)
        textArray = chatitem.textArray
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return textArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//
//        return headerText!
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: Int(ShareData.GetPhoneCurrentScreenWidth() - 100), height: headerHeight!+20)
        view.backgroundColor = UIColor.lightGray
        let lblheader = UILabel()
        lblheader.backgroundColor = UIColor.clear
        debugPrint(headerHeight!)
        lblheader.frame = CGRect(x: 5, y: 0, width: Int(ShareData.GetPhoneCurrentScreenWidth() - 110), height: 53)
        lblheader.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        lblheader.numberOfLines = 0
        lblheader.lineBreakMode = .byWordWrapping
        lblheader.text = headerText!
        lblheader.textAlignment = .center
        view.addSubview(lblheader)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        debugPrint(headerHeight!+20)
        return CGFloat(headerHeight!+20)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        let item = textArray[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text =  item["title"] as? String
        cell.textLabel?.textColor = UIColor.blue
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        debugPrint(indexPath.row)
         let item = textArray[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("TableAction"), object: nil, userInfo: ["Sender": item["title"] ?? ""])
    }
}
