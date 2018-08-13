//
//  StudentTableViewCell.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/15/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favValueLabel: UILabel!
    @IBOutlet weak var infoValueLabel: UILabel!

    @IBOutlet weak var iconImageView: UIImageView!

    var task: URLSessionTask?

    func bindingUI(_ student: StudentInfo) {
        titleLabel.text = "\(student.name) \(student.age) \(student.gender)"
        favValueLabel.text = student.favorite.joined(separator: ",")
        infoValueLabel.text = student.info.description

        guard let url = URL(string: student.url) else {return}
        self.task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            if let data = data,
                let image = UIImage(data: data) {
                // refresh collection
                DispatchQueue.main.async {
                     self.iconImageView.image = image
                }
            }
        }
        task?.resume()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.task?.cancel()
    }
}
