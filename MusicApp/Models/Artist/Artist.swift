//
//  Artist.swift
//  MusicApp
//
//  Created by Lalit Vinde on 24/09/23.
//

import Foundation

class Artist : Codable, Identifiable{
    let external_urls:ExternalUrls
    let followers:Followers?
    let genres:[String]?
    let href:String
    let id:String
    let name:String
    let images:[APIImage]?
}
