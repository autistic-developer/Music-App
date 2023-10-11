//
//  TopEndpoints.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

enum TopEndpoints{
    case artists(limit:Int, offset:Int)
    case tracks(limit:Int, offset:Int)
}

extension TopEndpoints : Endpoint{
    var path: String {
        switch self{
            
        case .artists:
            return "v1/me/top/artists"
        case .tracks:
            return "v1/me/top/tracks"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{
            
        case .artists(let limit, let offset):
            return [
                "limit" : limit,
                "offset" : offset
            ]
        case .tracks(limit: let limit, offset: let offset):
            return [
                "limit" : limit,
                "offset" : offset
            ]
        }
    }
    
    var method: RequestMethod {
        switch self{
        case .artists, .tracks:
            return .get
        }
    }
    
    var header: [String : String?]? {
        switch self{
        case .artists, .tracks:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{
        case .artists, .tracks:
            return nil
        }
    }
    
    
}

