//
//  UserInfo.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/11/18.
//

import Foundation

class UserInfo {

    var id: String
    var name: String?
    var email: String?
    var avatarURL: String?
    var dialogIDs: [String] = []
    var status: Int = 0

    init(id: String) {
        self.id = id
    }

}
