//
//  UserBussiness.swift
//  IQ69
//
//  Created by HuuNghia on 2/7/20.
//  Copyright © 2020 HuuNghia. All rights reserved.
//

import Foundation
import Firebase

public class UserBussiness {
    
    private var lstUser:[User] = []

    public func fetchUserData() -> [User] {
        if lstUser.count == 0 {
            createData()
        }
        return lstUser
    }
    
    public func createData() {
        var ref:DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeys(dict)
                self.lstUser.append(user)
                
                
            }
        }
    }
}
