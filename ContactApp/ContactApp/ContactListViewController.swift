//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by Thanh Quach on 8/11/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import SwiftyContacts
import Contacts
import SnapKit
import SVProgressHUD
import ESPullToRefresh

class ContactListViewController: UIViewController {

    fileprivate var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    fileprivate var restrictView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    fileprivate var refreshPermissionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        return button
    }()

    var contacts: [CNContact] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()
        self.requestContactPermission()
    }

    fileprivate func setupView() {
        self.view.backgroundColor = .white
        self.title = "Contact List"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
//        self.tableView.es.addPullToRefresh { [weak self] in
//            guard let `self` = self else {return}
//
//            self.getContacts()
//        }

        self.view.addSubview(restrictView)
        restrictView.isHidden = true
        restrictView.addSubview(refreshPermissionButton)

        refreshPermissionButton.addTarget(self, action: #selector(self.requestContactPermission), for: .touchUpInside)
    }

    fileprivate func setupConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalToSuperview()
            }
        }

        self.restrictView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.refreshPermissionButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }

    @objc fileprivate func requestContactPermission() {
        SVProgressHUD.show()
        requestAccess { [weak self] (granted) in
            guard let `self` = self else {return}
            SVProgressHUD.dismiss()

            DispatchQueue.main.async {
                if granted == false {
                    self.restrictView.isHidden = false
                    let alertController = UIAlertController(title: "Contact", message: "Please provide your contact permission at setting", preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Accept", style: .default, handler: { (_) in
                        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                        //
                    })
                    alertController.addAction(doneAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.restrictView.isHidden = true
                    self.getContacts()
                }
            }

        }
    }

    fileprivate func getContacts() {
        SVProgressHUD.show()
        fetchContactsOnBackgroundThread(completionHandler: { [weak self] (result) in
            guard let `self` = self else {return}

            SVProgressHUD.dismiss()
//            self.tableView.es.stopPullToRefresh()

            switch result{
            case .Success(response: let contacts):
                self.contacts = contacts
                self.tableView.reloadData()
                break
            case .Error(error: let error):
                print(error)
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                break
            }
        })
    }

}

// MARK: - UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactTableViewCell
        print(contacts[indexPath.row])
        cell.bindingUI(contacts[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let contactDetailViewController = ContactDetailViewController(contact: contacts[indexPath.row])
        self.navigationController?.pushViewController(contactDetailViewController, animated: true)
        return nil
    }
}
