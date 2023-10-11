//
//  AuthEndpoints.swift
//  MusicApp
//
//  Created by Lalit Vinde on 16/09/23.
//

import Foundation

enum AuthEndpoints{
    case authorization(client_id:String, scope:String, redirect_uri:String)
    case exchangeCodeForaToken(code: String,  redirect_uri:String, client_id:String, client_secret:String)
    case refreshAccessToken(refresh_token:String, client_id:String, client_secret:String)
}
extension AuthEndpoints : Endpoint{}

//MARK: host
extension AuthEndpoints{
    var host: Host {
        switch self{
        case .authorization, .exchangeCodeForaToken, .refreshAccessToken:
            return .auth
            
        }
    }
}
  
//MARK: path
extension AuthEndpoints{
    var path: String {
        switch self{
        case .authorization:
            return "authorize"
        case .exchangeCodeForaToken,.refreshAccessToken:
            return "api/token"
        }
    }
}

//MARK: query items
extension AuthEndpoints{
    var queryItems: [String : Any?]? {
        switch self{
        case .authorization(let client_id, let scope, let redirect_uri):
            return  [
                "response_type" : "code",
                "client_id" : client_id,
                "scope" : scope,
                "redirect_uri": redirect_uri,
                "state": String((0..<16).map { _ in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!}),
                "show_dialog": "TRUE"
            ]
        case .exchangeCodeForaToken, .refreshAccessToken:
            return nil
        }
    }
}

//MARK: method
extension AuthEndpoints{
    var method: RequestMethod {
        switch self{
        case .authorization:
            return .get
        case .exchangeCodeForaToken, .refreshAccessToken:
            return .post
        }
    }
    
}

//MARK: header
extension AuthEndpoints{
    var header: [String : String?]? {
        switch self{
        case .authorization:
            return nil
        case .exchangeCodeForaToken(_, _, let client_id, let client_secret), .refreshAccessToken(_,let client_id, let client_secret):
            guard let authHeaderVal = (client_id + ":" + client_secret).data(using: .utf8)?.base64EncodedString() else{
                fatalError("undable to encode Authorization header to base64 format")
            }
            return [
                "Authorization" : "Basic " + authHeaderVal,
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
            
        }
    }
    
}

//MARK: body
extension AuthEndpoints{
    var body: [String : String?]? {
        switch self{
        case .authorization:
            return nil
        case .exchangeCodeForaToken(let code, let redirect_uri, _, _):
            return [
                "grant_type" : "authorization_code",
                "code" : code,
                "redirect_uri" : redirect_uri
            ]
        case .refreshAccessToken(let refresh_token, _, _):
            return [
                "grant_type" : "refresh_token",
                "refresh_token" : refresh_token
            ]
        }
    }
    
}

