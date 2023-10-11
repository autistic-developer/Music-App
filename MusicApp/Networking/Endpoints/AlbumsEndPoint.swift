//
//  AlbumsEndPoint.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

enum AlbumsEndPoint{
    case savedAlbums(limit:Int, offset:Int)
}

extension AlbumsEndPoint:Endpoint{
   
    
    var path: String {
        switch self{

        case .savedAlbums:
            return "v1/me/albums"
        }
    }
    
    var queryItems: [String : Any?]? {
        switch self{

        case .savedAlbums(let limit, let offset):
            return [
                "limit":limit,
                "offset":offset
            ]
        }
    }
    
    var method: RequestMethod {
        switch self{

        case .savedAlbums:
            return .get
        }
    }
    
    var header: [String : String?]? {
        switch self{

        case .savedAlbums:
            return nil
        }
    }
    
    var body: [String : String?]? {
        switch self{

        case .savedAlbums:
            return nil
        }
    }
    
    
}
