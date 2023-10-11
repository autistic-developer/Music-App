//
//  Owner.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//

import Foundation
struct Owner:Codable{
    let external_urls: ExternalUrls
    //in doc they metioned it but it's not get return
    //so i made it nullable
    let followers: Followers?
    let href: String
    let id: String
    let uri: String
    let display_name: String?
}
