//
//  FBLoginViewController.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 7/2/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class FBLoginViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var usernameGGLabel: UILabel!
    @IBOutlet weak var idGGLabel: UILabel!

    var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
         // Optional: Place the button in the center of your view.
         loginButton.center = self.view.center;
         [self.view addSubview:loginButton];
         */

        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)

        let googleLoginButton = GIDSignInButton(frame: CGRect(x: 50, y: self.view.bounds.height-100, width: 100, height: 30))
        self.view.addSubview(googleLoginButton)

        let request = FBSDKGraphRequest(graphPath: "/me",
                                        parameters: ["fields": "id,name,email,address,picture"], httpMethod: "GET")
        _ = request?.start(completionHandler: { (connection, result, error) in
            print(connection)
            print(result)

            if let error = error {
                print(error.localizedDescription)
                return
            }

            self.parseUserFacebokInfo(result)
        })

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email

            self.idGGLabel.text = user.userID
            self.usernameGGLabel.text = user.profile.email
        }
    }

    func parseUserFacebokInfo(_ result: Any?) {
        /*
         {
            id = 263365394412723;
            name = "Quach Thanh";
            picture =     {
                data =         {
                    height = 50;
                    "is_silhouette" = 1;
                    url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?      asid=263365394412723&height=50&width=50&ext=1530795153&hash=AeTjUfjn4W52dS_w";
                    width = 50;
                    };
            };
         }
         */
        guard let result = result as? [String: Any] else {return}

        if let id = result["id"] as? String {
            self.idLabel.text = id
        }

        if let name = result["name"] as? String {
            self.usernameLabel.text = name
        }

        if let picture = result["picture"] as? [String: Any],
            let data = picture["data"] as? [String: Any],
            let url = data["url"] as? String {

            URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in

                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }.resume()
        }


    }

}

extension FBLoginViewController: GIDSignInUIDelegate {

    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {

    }

    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

}

extension FBLoginViewController: FBSDKLoginButtonDelegate {

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//            initWithGraphPath:@"/me"
//            parameters:@{ @"fields": @"id,name,email,address,picture",}
//            HTTPMethod:@"GET"];
//        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//            // Insert your code here
//            }];

        let request = FBSDKGraphRequest(graphPath: "/me",
                                        parameters: [
                                            "fields": "id,name,email,address,picture",
                                            "access_token" : "EAACEdEose0cBAIk0QZBqPwSyBpBEipECCE4OZAjQHPcTFA5p9JmGMjp5ZBBYTvtjkPeN4LuZAKZB1j1tvukVrZAifYs4khoZBBkxilHLbc9xpfo3yJqbflYWNe010dKDaf3Q4H0gJiZB2ycEuR0tuyLX0DD8Gf9ZAD9yDjTnmszHOk3HmZA8WCTv1FxStphbCRWb0ZD"
            ], httpMethod: "GET")
        _ = request?.start(completionHandler: { (connection, result, error) in
            print(connection)
            print(result)

            if let error = error {
                print(error.localizedDescription)
                return
            }

            self.parseUserFacebokInfo(result)
        })
    }



    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.avatarImageView.image = nil
        self.idLabel.text = nil
        self.usernameLabel.text = nil
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("loginButtonWillLogin")

        return true
    }

    @discardableResult
    func tong(a: Int, b: Int) -> Int {
        return a + b
    }
}
