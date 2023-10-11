//
//  TracksEndPoint.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

enum TracksEndPoint{
    case savedTracks(limit:Int, offset:Int)
}

extension TracksEndPoint:Endpoint{
    
    
    var path: String {
        switch self{

        case .savedTracks:
            return "v1/me/tracks"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{

        case .savedTracks(let limit, let offset):
            return [
                "limit":limit,
                "offset":offset
            ]
        }
    }
    
    var method: RequestMethod {
        switch self{

        case .savedTracks:
            return .get
        }
    }
    
    var header: [String : String?]? {
        switch self{

        case .savedTracks:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{

        case .savedTracks:
            return nil
        }
    }
    
    
}
