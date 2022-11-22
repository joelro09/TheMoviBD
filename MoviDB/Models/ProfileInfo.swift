//
//  ProfileInfo.swift
//  MoviDB
//
//  Created by Phinder 2022 on 21/11/22.
//

import Foundation

class ProfileInfo {
    
    static var shared: ProfileInfo = {
           let instance = ProfileInfo()
           return instance
    }()
    
    var profileInfo: LoginRequets?
    
    
    ///Banderas para usar en toda la app
    var token: String?{
        get{
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "token")
        }
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "token")
        }
    }
    
}
