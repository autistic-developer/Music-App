//
//  TopArtists.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

struct TopArtists : Codable {
    let href:String
    let next:String?
    let items:[Artist]
}

