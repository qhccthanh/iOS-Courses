//
//  AppDelegate.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 5/27/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey("AIzaSyCqZTIvAKNragV70kLoY76FjdK-q53_aOg")
        GMSPlacesClient.provideAPIKey("AIzaSyCJ0k1nQVgVmVrmv6DKG2yiuZH9VmGO5_s")

//        [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        GIDSignIn.sharedInstance().clientID = "533587611080-c72gn49984dt71slqrl5renovmp534ic.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options) || GIDSignIn.sharedInstance().handle(url as URL?,
                                                                                                                                            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                                                                                                            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//
//            var options: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
//                                                UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
//
//        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) || GIDSignIn.sharedInstance().handle(url,
//                                                                                                                                                                                                   sourceApplication: sourceApplication,
//                                                                                                                                                                                                   annotation: annotation)
//    }

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
            // ...
        }
    }
}

