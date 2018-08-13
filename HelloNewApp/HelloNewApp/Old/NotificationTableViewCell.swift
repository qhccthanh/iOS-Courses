//
//  NotificationTableViewCell.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/4/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
