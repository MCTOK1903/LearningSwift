//
//  UserSingleton.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 31.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation

class UserSignletion{
    
    static let sharedUserInfo = UserSignletion()
    
    var email = ""
    var username = ""
    
    private init(){
        
    }
    
}
