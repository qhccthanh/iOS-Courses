//
//  UserProfileViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/4/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    // 1 ÁNH XA IBOUTLET
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!

    // 2 KHỞI TẠO CÁC GIÁ TRỊ NHẬN DỮ LIỆU
    var username: String?
    var password: String?
    var confirmPassword: String?

    weak var signUpViewController: SignupViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 3 LÀ GÁN DỮ LIỆU VÀO VIEW
        usernameLabel.text = username
        passwordLabel.text = password
        confirmPasswordLabel.text = confirmPassword

        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func backAction() {
        self.signUpViewController?.userTapBack = "absdsfdsf"
    }

}

extension UIViewController {

    @IBAction func backRootAction(_ sender: Any!) {
        self.dismiss(animated: true, completion: nil)
    }

}
