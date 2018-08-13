//
//  DemoJSONViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/15/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit
import SafariServices

class DemoJSONViewController: UIViewController {

//    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var students: [StudentInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()


        let file1URL = Bundle.main.url(forResource: "jsondemo", withExtension: "json")
//        let file2URL = Bundle.main.url(forResource: "demojson", withExtension: "json")

        if let file1URL = file1URL,
            let fileData = try? Data.init(contentsOf: file1URL),
        let jsonArray = try? JSONSerialization.jsonObject(with: fileData, options: .mutableLeaves) as? [[String: Any]]
        {
//            displayLabel.text = json?.description
            for json in jsonArray! {
                let name = json["name"] as? String ?? ""
                let age = json["age"] as? Int ?? 0
                let url = json["url"] as? String ?? ""
                let gender = json["gender"] as? Bool ?? false
                let favs = json["favorite"] as? [String] ?? []
                let info = json["info"] as? [String: Any] ?? [:]

                let student = StudentInfo(name: name, age: age, url: url, gender: gender, favorite: favs, info: info)
                students.append(student)
            }
        }
        tableView.reloadData()
//        if let file1URL = file2URL,
//            let fileData = try? Data.init(contentsOf: file1URL),
//            let json = try? JSONSerialization.jsonObject(with: fileData, options: .mutableLeaves) as? [String: Any]
//        {
//            displayLabel.text = "\(displayLabel.text ?? "")\r\n\(json?.description ?? "")"
//        }

    }

}

extension DemoJSONViewController: UITableViewDataSource, UITableViewDelegate { 

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell") as? StudentTableViewCell
        let student = students[indexPath.row]
        cell?.bindingUI(student)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "https://www.google.com.vn/")!
        if !UIApplication.shared.canOpenURL(url) {
            return
        }

        if #available(iOS 9.0, *) {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

