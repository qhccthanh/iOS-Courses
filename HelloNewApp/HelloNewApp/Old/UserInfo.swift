//
//  UserInfo.swift
//  HelloNewApp
//
//  Created by Thanh Quach on 6/8/18.
//  Copyright © 2018 Sea Group Limited. All rights reserved.
//

import Foundation

// 2. Kế thừa NSObject, NSCoding
class UserInfo: NSObject, NSCoding {

    // 3
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.age, forKey: "age")
    }

    required init?(coder aDecoder: NSCoder) {

        // String
        self.username = aDecoder.decodeObject(forKey: "username") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String

        // Int
        self.gender = Int(aDecoder.decodeCInt(forKey: "gender"))
        self.age = Int(aDecoder.decodeCInt(forKey: "age"))

        // Bool
//        aDecoder.decodeBool(forKey: "Bool")

        // Float
//        aDecoder.decodeFloat(forKey: "Float")
    }

    override init() {
        super.init()
    }

    var username: String = ""
    var password: String = ""
    var gender: Int = 0
    var age: Int = 0

    func getInfo() -> [(title: String, subTitle: String)] {
        var result: [(title: String, subTitle: String)] = []

        result.append(("username", self.username))
        result.append(("password", self.password))
        result.append(("gender", "\(self.gender)"))
        result.append(("age", "\(self.age)"))

        return result
    }


}

// 1 Copy 2 hàm này
func insertItems() {
    let defaults = UserDefaults.standard
    // listUser => Data
    let data = NSKeyedArchiver.archivedData(withRootObject: listUsers)
    defaults.set(data, forKey: "listUsers")
}

func retrieveItems() -> [UserInfo] {
    if let data = UserDefaults.standard.object(forKey: "listUsers") as? NSData {
        let _mySavedList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [UserInfo] ?? []
        return _mySavedList
    }

    return []
}

// 4 gọi hàm
var listUsers: [UserInfo] = retrieveItems()
