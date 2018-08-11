//
//  PhoneTableViewCell.swift
//  ContactApp
//
//  Created by Thanh Quach on 8/11/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import Contacts

let changePhoneNumberDict = [
    "0186" : "056",
    "0120": "070",
    "0123": "083",
    "0162": "032",
]


class PhoneTableViewCell: UITableViewCell {

    fileprivate var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(5, 14, 5, 14))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindingUI(_ phone: String, newPhone: String) {
        self.phoneLabel.text = "Số cũ: \(phone) ==> Số mới: \(newPhone)"
    }
}
