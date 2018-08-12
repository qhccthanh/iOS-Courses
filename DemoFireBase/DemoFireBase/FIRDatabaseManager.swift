//
//  FIRDatabaseManager.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/11/18.
//

import Foundation
import FirebaseDatabase

class FIRDatabaseManager {

    static let shared: FIRDatabaseManager = FIRDatabaseManager()
    let ref: DatabaseReference

    var userRef: DatabaseReference {
        return ref.child("users")
    }

    private init() {
        ref = Database.database().reference().child("hellofirebaseapp")
    }

}
