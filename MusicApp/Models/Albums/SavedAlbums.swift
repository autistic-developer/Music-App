//
//  SavedAlbums.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation
struct SavedAlbums:Codable{
    let href: String
    let next:String?
    let previous:String?
    let items:[SavedAlbumObject]
}

struct SavedAlbumObject:Codable{
    let added_at:String
    let album:Album
}
