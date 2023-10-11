//
//  RequestError.swift
//  MusicApp
//
//  Created by Lalit Vinde on 16/09/23.
//

import Foundation

enum RequestError: Int, Error {
    case badURL
    case noResponse
    case decode
    case tokenError
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    
    var customMessage: String {
        switch self {
        case .tokenError:
            return "Token doesn't exist"
        case .badURL:
            return "Invalid URL"
        case .noResponse:
            return "Got no respose body"
        case .decode:
            return "Got no respose body"
        case .badRequest:
            return "Bad Request - The request could not be understood by the server due to malformed syntax."
        case .unauthorized:
            return "Unauthorized - The request requires user authentication or authorization has been refused."
        case .forbidden:
            return "Forbidden - The server understood the request but is refusing to fulfill it."
        case .notFound:
            return "Not Found - The requested resource could not be found."
        case .tooManyRequests:
            return "Too Many Requests - Rate limiting has been applied."
        case .internalServerError:
            return "Internal Server Error - An unexpected error occurred on the server."
        case .badGateway:
            return "Bad Gateway - The server received an invalid response from the upstream server."
        case .serviceUnavailable:
            return "Service Unavailable - The server is currently unable to handle the request."
        }
    }
}
