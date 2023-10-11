//
//  AuthResponse.swift
//  MusicApp
//
//  Created by Lalit Vinde on 17/09/23.
//

import Foundation
extension AuthService{
    struct AuthResponse:Codable{
        let access_token : String
        let token_type : String
        let scope : String
        let expires_in : Int
        let refresh_token : String?
    }
}
