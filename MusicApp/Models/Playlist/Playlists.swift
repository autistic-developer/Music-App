//
//  Playlist.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//

import SwiftUI
struct Playlists:Codable{
    let href:String
    let limit:Int
    let next:String?
    let offset:Int
    let previous:String?
    let total:Int
    let items:[Playlist]
}
struct Playlist: Codable, Identifiable, Equatable{
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        lhs.id == rhs.id
    }
    
    let collaborative: Bool
    let description: String?
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let owner: Owner
//    let tracks: [SavedTrack]?
}


