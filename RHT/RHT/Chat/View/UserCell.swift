//
//  UserCell.swift
//  RHT
//
//  Created by kamal on 30/09/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
