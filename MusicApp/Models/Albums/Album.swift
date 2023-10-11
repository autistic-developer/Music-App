//
//  Album.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

struct Album:Codable, Identifiable{
    let album_type: String
    let total_tracks: Int
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    

}
