//
//  PlaylistEndpoints.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//

import Foundation

enum PlaylistEndpoints {
    case usersPlaylist(user_id:String, limit:Int?, offset:Int?)
    case playlistTracks(playlist_id:String, limit:Int?, offset:Int?)
}

extension PlaylistEndpoints : Endpoint{
    var path: String {
        switch self{
            
        case .usersPlaylist(let user_id, _, _):
            return "v1/users/\(user_id)/playlists"
            
        case .playlistTracks(let playlist_id , _, _):
            return "v1/playlists/\(playlist_id)/tracks"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{

        case .usersPlaylist(_ , let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
            
        case .playlistTracks(_ , let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
            
        }
    }
    
    var method: RequestMethod {
        switch self{

        case .usersPlaylist:
            return .get
        
        case .playlistTracks:
            return .get
        }
        
    }
    
    var header: [String : String?]? {
        switch self{

        case .usersPlaylist:
            return nil
            
        case .playlistTracks:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{

        case .usersPlaylist:
            return nil
        
        case .playlistTracks:
            return nil
            
        }
    }
    
    
}

