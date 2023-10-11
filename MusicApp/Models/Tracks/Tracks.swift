//
//  SavedTracks.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

struct Tracks: Codable{
    let href:String
    let next:String?
    let items:[TackObject]
}
struct TackObject:Codable {
    let added_at: String
    let track:Track
   
}
