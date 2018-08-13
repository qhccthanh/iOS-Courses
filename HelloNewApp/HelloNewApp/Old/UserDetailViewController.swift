//
//  UserDetailViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/8/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource {

    var userInfo: UserInfo!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.getInfo().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let info = userInfo.getInfo()[indexPath.row]

        cell.textLabel?.text = info.title
        cell.detailTextLabel?.text = info.subTitle

        return cell
    }

}

