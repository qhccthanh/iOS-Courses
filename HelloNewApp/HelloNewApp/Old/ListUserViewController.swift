//
//  ListUserViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/8/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class ListUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ListUserViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")

        let userInfo = listUsers[indexPath.row]
        cell.textLabel?.text = userInfo.username

        return cell
    }

}

extension ListUserViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userInfo = listUsers[indexPath.row]

        // truyền user info này vào UserDetailViewController
        let userDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController
        userDetailViewController!.userInfo = userInfo

        self.present(userDetailViewController!, animated: true, completion: nil)
    }

}
