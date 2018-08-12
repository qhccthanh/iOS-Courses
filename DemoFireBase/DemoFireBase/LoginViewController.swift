//
//  ViewController.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/9/18.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {

    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Nhap email"
        return textField
    }()

    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Nhap password"
        return textField
    }()

    fileprivate let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign-in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    fileprivate let ggSignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google-SignIn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    fileprivate let fbSignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook-SignIn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self

        // Login
        if let user = UserManager.shared.getCurrentUser() {
            // -> da login
            // ...
            print(user)
        }

        // Logout:
        // try Auth.auth().signOut() // Firebase
        // FBSDKLoginManager().logOut()
        // GIDSignIn.sharedInstance().signOut()

        // back ve man hinh login
    }

    fileprivate func setupView() {
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(ggSignInButton)
        self.view.addSubview(fbSignInButton)

//        self.view.backgroundColor = .lightGray
        self.signInButton.addTarget(self, action: #selector(self.didTapSignInButton(_:)), for: .touchUpInside)
        self.ggSignInButton.addTarget(self, action: #selector(self.didTapGoogleSignInBtn(_:)), for: .touchUpInside)
        self.fbSignInButton.addTarget(self, action: #selector(self.didTapFacebookSignInBtn(_:)), for: .touchUpInside)
    }

    fileprivate func setupConstraints() {

        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(10)
            make.left.right.equalTo(self.emailTextField)
        }

        self.signInButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }

        self.ggSignInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(signInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }

        self.fbSignInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(ggSignInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }

    @objc fileprivate func didTapSignInButton(_ sender: Any!) {
        // Loading
        // SVProgressHUD
        // MBProgressHUD
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
//            // Hide
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            print(result?.user)
//            print(result?.additionalUserInfo)
//        }

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if let error = error {
                // AuthErrorCode.wrongPassword
                print(error.localizedDescription)

                return
            }

            print(result?.user)
            print(result?.additionalUserInfo)
            self.handleLoginSucceed(user: result?.user)
        }
    }

    @objc fileprivate func didTapGoogleSignInBtn(_ sender: Any!) {
        GIDSignIn.sharedInstance().signIn()
    }

    @objc fileprivate func didTapFacebookSignInBtn(_ sender: Any!) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }

                print(authResult?.user)
                print(authResult?.additionalUserInfo)
                print(authResult?.additionalUserInfo?.profile)
                self.handleLoginSucceed(user: authResult?.user)
            }
        }
    }

    fileprivate func handleLoginSucceed(user: User?) {

        guard let fireUser = user else {return}

        FIRDatabaseManager.shared.userRef.child(fireUser.uid).setValue([
            "name": fireUser.displayName ?? "",
            "email": fireUser.email ?? "",
            "id": fireUser.uid,
            "avatar_url": fireUser.photoURL?.absoluteString ?? "",
            "dialog_ids": []
            ])

        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") else {
            return
        }

        self.present(controller, animated: true, completion: nil)
    }
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }

            print(authResult?.user)
            print(authResult?.additionalUserInfo)
            print(authResult?.additionalUserInfo?.profile)
            self.handleLoginSucceed(user: authResult?.user)
        }
    }

}

