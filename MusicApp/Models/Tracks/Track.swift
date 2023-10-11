//
//  Track.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation
struct Track:Codable,Identifiable, Equatable{
    static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.id == rhs.id
    }
    
    let album:Album
    let artists:[Artist]
    let duration_ms:Int
    let external_urls:ExternalUrls
    let preview_url:String?
    let href:String
    let name:String
    let id:String
}

struct TrackWrapper: Identifiable {
    let id = UUID()
    let track: Track
}

