//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Thanh Quach on 8/11/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import Contacts

class ContactTableViewCell: UITableViewCell {

    var contact: CNContact?

    fileprivate var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    fileprivate var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupView()
        self.setupContrainst()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupView()
        self.setupContrainst()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupView() {
        self.contentView.addSubview(fullNameLabel)
        self.contentView.addSubview(phoneLabel)
    }

    fileprivate func setupContrainst() {
        self.fullNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(14)
            make.right.lessThanOrEqualToSuperview().offset(-14)
        }

        self.phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.fullNameLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(14)
            make.right.lessThanOrEqualToSuperview().offset(-14)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
    }

    func bindingUI(_ contact: CNContact) {
        self.contact = contact
        self.fullNameLabel.text = "\(contact.familyName) \(contact.givenName)"

        let phoneNumbers = contact.phoneNumbers.map { (cnPhoneNumber) -> String in
            return cnPhoneNumber.value.stringValue
        }
        self.phoneLabel.text = "\(phoneNumbers.joined(separator: ","))"
    }

}
