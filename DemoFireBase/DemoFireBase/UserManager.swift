//
//  UserManager.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/9/18.
//

import Foundation
import FirebaseAuth

class UserManager {

    static let shared: UserManager = UserManager()

    private init() {

    }

    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }

}
