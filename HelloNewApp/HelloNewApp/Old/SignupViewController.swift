//
//  SignupViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/3/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    var userTapBack: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {

        // sakdjasdkdasdsa
    }

    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        print("signUpAction")
    }

    @IBAction func segmentGenderChangedAction(_ sender: UISegmentedControl) {
        print("segmentGenderChangedAction: \(sender.selectedSegmentIndex)")

        // Alert thông báo rằng bạn đã thay đổi giới tính
    }

    @IBAction func onSwitchPolicyAction(_ sender: UISwitch) {
        print("onSwitchPolicyAction: \(sender.isOn)")

        // Alert bạn đã bật hoặc tắt
    }

    @IBAction func slideAgeAction(_ sender: UISlider) {
        print("slideAgeAction: \(Int(sender.value))")
        // Typecast (ép kiêu) : Int(giá tri cần ép kiểu)
        // self.label.text = Int()
    }

    @IBAction func didTapSignupBtn(_ sender: UIButton) {

        // 1. Username hoặc password > 0
        if usernameTextField.text?.count == 0 || passwordTextField.text?.count == 0 {
            //
            self.showAlert(title: "ABC", message: "Username hoặc password > 0")
            return
        }

        // 2 Username khong đc có ký tự đặc biệt (#)
        // if let
        // guard let
        if usernameTextField.text?.contains("#") ?? false {
            //
            self.showAlert(title: "ABC", message: "Username khong đc có ký tự đặc biệt (#)")
            return
        }

        // 3 Password.count > 6
        if passwordTextField.text?.count ?? 0 < 6 {
            //
            self.showAlert(title: "ABC", message: "Password.count > 6")
            return
        }

        // 4 ConfirmPassword == password
        if passwordTextField.text != confirmPasswordTextField.text {
            self.showAlert(title: "ABC", message: "ConfirmPassword == password")
            return
        }

        // Input valid (giá trị hợp lệ)

        // 4 tạo viewcontroller cần truyền dữ liệu
        guard let userProfileController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController else {
            return
        }

        // 5 gán dữ liệu vào biến
        let userInfo = UserInfo()
        userInfo.username = usernameTextField.text ?? ""
        userInfo.password = passwordTextField.text ?? ""
        userInfo.gender = 10
        userInfo.age = 20

        listUsers.append(userInfo)
//        UserDefaults.standard.set(listUsers, forKey: "listUsers")

        // 5 Luu lai thong tin
        insertItems()

//        userProfileController.username = usernameTextField.text
//        userProfileController.password = passwordTextField.text
//        userProfileController.confirmPassword = confirmPasswordTextField.text
//        userProfileController.signUpViewController = self
//        // 6 Show viewcontroller lên
//        self.present(userProfileController, animated: true, completion: nil)
    }

    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Cacncel", style: .cancel, handler: nil)

        alertController.addAction(alertAction)

        self.present(alertController, animated: true, completion: nil)
    }


}
