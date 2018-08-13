//
//  DemoTableViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/4/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class DemoTableViewController: UIViewController {

    var username: String?
    var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSource
extension DemoTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
//
//        var result = ""
//        for _ in 0...(indexPath.row+1) {
//            result += "\(indexPath.row) - \(indexPath.section)\r\n"
//        }
//        cell.titleLabel.text = result
//
//        return cell
        // Row usernamename
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "abc")
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Username"
            cell.detailTextLabel?.text = self.username
        case 1: // password
            cell.textLabel?.text = "Password"
            cell.detailTextLabel?.text = self.password
        default:
            return cell
        }

        return cell
    }

}

// UITableViewDelegate
extension DemoTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print("willSelectRowAt \(indexPath)")
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

//        if indexPath.row == 0 {
//            return 100
//        }
//
//        return 44
        return 44
    }

}
