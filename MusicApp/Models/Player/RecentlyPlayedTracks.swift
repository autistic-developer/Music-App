//
//  RecentlyPlayedTracks.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation
struct RecentlyPlayedTracks:Codable {
    let href:String
    let next:String?
    let items:[PlayHistoryObject]
    let cursors: Cursors?
}

struct Cursors:Codable{
    let after:String
    let before:String
}

struct PlayHistoryObject:Codable {
    let track:Track
}
