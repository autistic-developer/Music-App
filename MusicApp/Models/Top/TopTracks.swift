//
//  TopTracks.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation

struct TopTracks : Codable {
    let href:String
    let next:String?
    let items:[Track]
}
