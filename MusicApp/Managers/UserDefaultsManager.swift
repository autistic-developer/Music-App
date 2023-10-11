//
//  UserDefaults.swift
//  MusicApp
//
//  Created by Lalit Vinde on 16/09/23.
//

import Foundation
protocol UserDefaultManable{
    subscript(key: UserDefaultsManager.Keys) -> Any? {get set}
}
final class UserDefaultsManager:UserDefaultManable{
    let userDefault: UserDefaults
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    subscript(key: UserDefaultsManager.Keys) -> Any?{
        get {
            userDefault.object(forKey: key.rawValue)
        }
        set(newValue) {
            userDefault.set(newValue, forKey: key.rawValue)
        }
    }
}

extension UserDefaultsManager{
    enum Keys:String{
        case access_toke
        case refresh_token
        case expiration_date
    }
}
