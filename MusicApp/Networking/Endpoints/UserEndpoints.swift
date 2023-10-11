//
//  UserEndpoints.swift
//  MusicApp
//
//  Created by Lalit Vinde on 17/09/23.
//

import Foundation
enum UserEndpoint{
    case userProfile
}
extension UserEndpoint : Endpoint{
    var path: String {
        switch self{
        case .userProfile:
            return "v1/me"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{
        case .userProfile:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self{
        case .userProfile:
            return .get
        }
    }
    
    var header: [String : String?]? {
        switch self{
        case .userProfile:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{
        case .userProfile:
            return nil
        }
    }
    
    
}

