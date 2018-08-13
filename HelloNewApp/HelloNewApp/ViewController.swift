//
//  ViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 5/27/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signupLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        UserDefaults.standard.set("Toi di hoc", forKey: "toidihoc")
//        print(UserDefaults.standard.string(forKey: "toidihoc"))

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSignUpGesture(_:)))
        self.signupLabel.addGestureRecognizer(tapGesture)
        self.signupLabel.isUserInteractionEnabled = true // UIView, UILabel, UImageView, ...

        // Bước 0 tạo 1 hàm xử lý khi tap vào component
        // Bước 1 Tạo 1 UITapGestureRecognizer
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapTitleGesture(_:)))
        // Bước 2 Thêm gesture vào component gọi hàm addGestureRecognizer
        self.titleLabel.addGestureRecognizer(tapGesture1)
        // Bước 3 Set thuộc tính isUserInteractionEnabled = true
        self.titleLabel.isUserInteractionEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    

    @objc func tapTitleGesture(_ gesture: UIGestureRecognizer) {

    }

    func testFunc(a: Int) {}
    func testFuncB(_ a: Int) {}

    @objc func tapSignUpGesture(_ gesture: UIGestureRecognizer) {

        // Cách 1 if let
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") {
//            self.present(controller, animated: true, completion: nil)
            self.navigationController?.pushViewController(controller, animated: true)
        }

        // Cách 2 guard
//        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController")  else {
//            return
//        }
//        self.present(controller, animated: true, completion: nil)

    }

    
    @IBAction func loginAction(_ sender: UIButton) {

        let username = "iMIC2018"
        let password = "123456"

        var userInfoDangTim: UserInfo?
        listUsers.forEach { (userInfo ) in
            if userInfo.username == self.usernameTextField.text && userInfo.password == self.passwordTextField.text {
                userInfoDangTim = userInfo
            }
        }

        if let userInfo = userInfoDangTim {
            let alertController = UIAlertController(title: "Login", message: "Ban da dang nhap thanh cong voi username: \(userInfo.username) password: \(userInfo.password)", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Không muốn", style: .cancel) { (_) in
                print("Cancel")
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }

        if self.usernameTextField.text == username && self.passwordTextField.text == password {
            let alertController = UIAlertController(title: "Login", message: "Bạn có muốn login không?", preferredStyle: .alert)
            let okeAction = UIAlertAction(title: "Tôi muốn", style: .default) { (_) in
                print("Oke")
            }
//            let destructiveAction = UIAlertAction(title: "Không muốn", style: .destructive) { (_) in
//                print("destructiveAction")
//            }
            let cancelAction = UIAlertAction(title: "Không muốn", style: .cancel) { (_) in
                print("Cancel")
            }

            alertController.addAction(okeAction)
            alertController.addAction(cancelAction)
//            alertController.addAction(destructiveAction)

            self.present(alertController, animated: true, completion: nil)
        } else if self.usernameTextField.text?.count == 0 && self.passwordTextField.text?.count == 0 {
            let alertController = UIAlertController(title: "Login", message: "Bạn chưa nhập thông tin vui lòng nhập thông tin", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Không muốn", style: .cancel) { (_) in
                print("Cancel")
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Login", message: "Bạn đã nhập sai thông tin đăng nhập", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Không muốn", style: .cancel) { (_) in
                print("Cancel")
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }


    }


}

