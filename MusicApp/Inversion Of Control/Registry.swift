//
//  Registry.swift
//  Chat App
//
//  Created by Lalit Vinde on 24/08/23.
//
import Foundation


private struct UserDefaultManableKey: InjectionKey {
    static var currentValue: UserDefaultManable = UserDefaultsManager(userDefault: UserDefaults.standard)
}

private struct AuthenticatableKey: InjectionKey {
    static var currentValue: AuthServicable = AuthService(userDefault: InjectedValues[UserDefaultManableKey.self])
   
}
struct HTTPClientBehaviorKey : InjectionKey{
    static var currentValue: HTTPClientBehavior = HTTPClient(authService: InjectedValues[AuthenticatableKey.self])
}



extension InjectedValues{
    var userDefault : UserDefaultManable{
        get{ Self[UserDefaultManableKey.self] }
        set{ Self[UserDefaultManableKey.self] = newValue}
    }
    
    var authService : AuthServicable{
        get{ Self[AuthenticatableKey.self] }
        set{ Self[AuthenticatableKey.self] = newValue}
    }
   
    var httpClient : HTTPClientBehavior{
        get{ Self[HTTPClientBehaviorKey.self] }
        set{ Self[HTTPClientBehaviorKey.self] = newValue}
    }
}


