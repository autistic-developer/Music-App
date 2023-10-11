//
//  Endpoint.swift
//  MusicApp
//
//  Created by Lalit Vinde on 15/09/23.
//

import Foundation
enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum Host: String {
    case auth = "accounts.spotify.com"
    case base = "api.spotify.com"
}


protocol Endpoint {
    var scheme: String { get }
    var host: Host { get }
    var path: String { get }
    var queryItems: [String: Any?]? { get }
    var method: RequestMethod { get }
    var header: [String: String?]? { get }
    var body: [String: String?]? { get }
}
extension Endpoint {
    var scheme: String { "https" }
    var host: Host { .base }
}



extension Endpoint{
    var url : URL?  {
        let components = components
        
        return components.url 
    }
    
    var components : URLComponents{
        var components = URLComponents()
        components.scheme = scheme
        components.host = host.rawValue
        components.path = "/" + path
        if let queryItems {
            components.queryItems = queryItems.compactMapValues({$0}).map({ (key: String, value: Any) in
                URLQueryItem(name: key, value: String(describing: value) )
            })
        }
        
        return components
    }
}

