//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by Thanh Quach on 8/11/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import SwiftyContacts
import Contacts
import SVProgressHUD

fileprivate let defaultUndefindPhone = "Không xác định"
class ContactDetailViewController: UIViewController {

    var contact: CNContact

    fileprivate var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    var newPhones: [String] = []

    init(contact: CNContact) {
        self.contact = contact

        newPhones = self.contact.phoneNumbers.map { (phone) in
            let oldPhone = phone.value.stringValue
            var newPhone = defaultUndefindPhone
            if oldPhone.count > 5 {
                if String(oldPhone.first!) == "0" {
                    let index = oldPhone.index(oldPhone.startIndex, offsetBy: 4)
                    let prefixPhone = String(oldPhone.prefix(upTo: index))

                    if let prefixChange = changePhoneNumberDict[prefixPhone] {
                        let subString = String(oldPhone[index...])
                        newPhone = prefixChange + subString
                    }
                }
                return newPhone
            }
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupContrainst()
    }

    fileprivate func setupView() {
        self.title = "\(contact.familyName) \(contact.givenName)"
        self.view.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 30
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: "PhoneCell")
    }

    fileprivate func setupContrainst() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalToSuperview()
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension ContactDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.phoneNumbers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell") as! PhoneTableViewCell
        let phone = self.contact.phoneNumbers[indexPath.row]
        cell.bindingUI(phone.value.stringValue, newPhone: newPhones[indexPath])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let newPhone = newPhones[indexPath.row]
        if newPhone == defaultUndefindPhone {
            SVProgressHUD.showError(withStatus: "Số điện thoại không thể đổi")
            SVProgressHUD.dismiss(withDelay: 2)
            return nil
        }

        contact.phoneNumbers[indexPath.row] = contact.phoneNumbers[indexPath.row].settingValue(CNPhoneNumber(stringValue: newPhone))
        contact.set

        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


