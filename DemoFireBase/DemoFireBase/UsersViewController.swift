//
//  UsersViewController.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/11/18.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var currentStatusID: Int = 0
    var users: [UserInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        FIRDatabaseManager.shared.ref.child("users").observe(.value) { (snapShot) in
            print(snapShot.value)
            self.bindingUI(users: snapShot.value as? [String : Any])
        }

    }

    func bindingUI(users: [String: Any]?) {

        self.users.removeAll()

        guard let users = users else {
            self.users = []
            self.tableView.reloadData()
            return
        }

        for value in users.values {
            if let userValue = value as? [String: Any] {
                let avatarURL = userValue["avatar_url"] as? String
                let name = userValue["name"] as? String
                let id = userValue["id"] as? String ?? ""
                let email = userValue["email"] as? String
                let dialogIDs = userValue["dialog_ids"] as? [String] ?? []
                let status = userValue["status"] as? Int ?? 0

                let userInfo = UserInfo(id: id)
                userInfo.name = name
                userInfo.avatarURL = avatarURL
                userInfo.email = email
                userInfo.dialogIDs = dialogIDs
                userInfo.status = status

                self.users.append(userInfo)
            }
        }

        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let userInfo = self.users[indexPath.row]
        cell.textLabel?.text = userInfo.id
        cell.detailTextLabel?.text = userInfo.name

        if userInfo.status == 0 {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .gray
        }

        return cell
    }

    @IBAction func logOutBtn(_ sender: Any!) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func changeStatus(_ sender: Any!) {

        guard let currentUserUID = UserManager.shared.getCurrentUser()?.uid else {
            return
        }

        FIRDatabaseManager.shared.userRef.child(currentUserUID).child("status").setValue(self.currentStatusID)

        // 0 - 1
        if self.currentStatusID == 0 {
            self.currentStatusID = 1
        } else {
            self.currentStatusID = 0
        }
    }
}
