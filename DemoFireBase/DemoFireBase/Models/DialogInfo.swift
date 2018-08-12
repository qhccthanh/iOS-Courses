//
//  DialogInfo.swift
//  DemoFireBase
//
//  Created by Thanh Quach on 7/11/18.
//

import Foundation

class DialogInfo {

    var id: String
    var createdOn: Date
    var updatedOn: Date
    var messageIDs: [String] = []
    var participants: [String] = []

    init(id: String, createdOn: Date, updatedOn: Date) {
        self.id = id
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}
