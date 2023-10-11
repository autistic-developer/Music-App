//
//  ResentTracksEndPoint.swift
//  MusicApp
//
//  Created by Lalit Vinde on 25/09/23.
//

import Foundation

enum RecentTracksEndPoint{
    case resentTracks(limit:Int, after:Int?)
}
extension RecentTracksEndPoint : Endpoint{
    var path: String {
        switch self{
        case .resentTracks:
            return "v1/me/player/recently-played"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{
        case .resentTracks(let limit, let after):
            return [
                "limit": limit,
                "after" : after
            ]
        }
    }
    
    var method: RequestMethod {
        switch self{
        case .resentTracks:
            return .get
        }
    }
    
    var header: [String : String?]? {
        switch self{
        case .resentTracks:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{
        case .resentTracks:
            return nil
        }
    }
    
}
