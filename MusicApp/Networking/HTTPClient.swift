//
//  HTTPClient.swift
//  MusicApp
//
//  Created by Lalit Vinde on 16/09/23.
//

import Foundation
protocol HTTPClientBehavior {
    func loadData<T:Codable> (endpoint: Endpoint) async ->  T
}

class HTTPClient : HTTPClientBehavior{
    
    private let authService: AuthServicable
    
    init(authService: AuthServicable) {
        self.authService = authService
    }
    
    func loadData<T:Codable> (endpoint: Endpoint) async ->  T{
        do{
            let (data, response) = try await request(endpoint: endpoint)
            try handelResponseCode(response: response)
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch{
            preconditionFailure(error.localizedDescription)
        }
    }
    
     
    private func request(
        endpoint: Endpoint
    ) async throws -> (Data, URLResponse) {
        
        guard let url = endpoint.url else {
            throw RequestError.badURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue
        guard let accessToken = await authService.getValidAccessToken() else {
            throw RequestError.tokenError
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = endpoint.header?.compactMapValues({$0})
        
        do {
            if let body = endpoint.body?.compactMapValues({$0}) {
                
                var components = URLComponents()
                components.queryItems = body.map({ (key: String, value: String) in
                    return URLQueryItem(name: key, value: value)
                })
                
                request.httpBody =  components.query?.data(using: .utf8)
                                
            }
            
            return try await URLSession.shared.data(for: request)
        } catch {
            throw error
        }
    }
    
    private func handelResponseCode(response: URLResponse) throws {
        guard let respose = response as? HTTPURLResponse else{ return }
        let statusCode = respose.statusCode
        if (200...299).contains(statusCode) {
            return
        }
        else if let error = RequestError(rawValue: statusCode){
            throw error
        }
    }
}
