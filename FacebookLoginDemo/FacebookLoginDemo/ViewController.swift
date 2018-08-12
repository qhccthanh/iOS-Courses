//
//  ViewController.swift
//  FacebookLoginDemo
//
//  Created by Thanh Quach on 8/12/18.
//  Copyright © 2018 Thanh Quach. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbLoginAction(_ sender: Any) {
        let loginManager = FBSDKLoginManager()

        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            //
        }
    }

    @IBAction func ggLoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {

    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Lay thong tin user dang nhap voi firebase
    }
}

