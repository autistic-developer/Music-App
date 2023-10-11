import Foundation

struct User: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: ExplicitContent
    let external_urls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [APIImage]
    let product: String
    let type: String
    let uri: String

    
}

struct ExplicitContent: Codable {
    let filterEnabled: Bool
    let filterLocked: Bool

    private enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}




