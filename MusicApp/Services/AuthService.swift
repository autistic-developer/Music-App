//
//  AuthService.swift
//  MusicApp
//
//  Created by Lalit Vinde on 14/09/23.
//

import Foundation


protocol AuthServicable:Actor{
    nonisolated func signInURL() -> URL?
    func exchangeCodeForToken(code:String) async
    func getValidAccessToken() async -> String?
}
final actor AuthService : AuthServicable {
   
    private var userDefault: UserDefaultManable
    
    init(userDefault: UserDefaultManable) {
        self.userDefault = userDefault
    }
    
    struct Constants{
        static let client_id = "0918ae1f26894ec195868f19c6022a38"
        static let cliend_secret = "451727d4d41448c498963aef19c60c30"
        static let scope = "user-read-private user-read-email playlist-modify-public playlist-read-private playlist-modify-private user-follow-read user-library-modify user-library-read playlist-read-collaborative user-read-recently-played user-top-read"
        static let redirect_uri = "https://www.google.com"
    }
    
    
    nonisolated func signInURL() -> URL? {
        return AuthEndpoints.authorization(
            client_id: Constants.client_id,
            scope: Constants.scope,
            redirect_uri: Constants.redirect_uri).url
    }
    
    func exchangeCodeForToken(code:String) async{
        let endpoint = AuthEndpoints.exchangeCodeForaToken(
            code: code,
            redirect_uri: Constants.redirect_uri,
            client_id: Constants.client_id,
            client_secret: Constants.cliend_secret)
        
        
        let authResponse:AuthService.AuthResponse = await loadData(endpoint: endpoint)
        
        cacheToken(authResponse: authResponse)
        
    }
    
    func getValidAccessToken() async -> String? {
        await refreshAccessTokenIfNeeded()
        return accessToken
    }
    
    private func refreshAccessTokenIfNeeded() async {
        if shouldRefreshToken{
            if let refresh_token = self.refreshToken{
                let endpoint = AuthEndpoints.refreshAccessToken(refresh_token: refresh_token, client_id: Constants.client_id, client_secret: Constants.cliend_secret)
                
                let authResponse:AuthService.AuthResponse = await loadData(endpoint: endpoint)
                
                cacheToken(authResponse: authResponse)
            }
            
        }
    }
    
    private func cacheToken(authResponse:AuthService.AuthResponse){
        userDefault[.access_toke] = authResponse.access_token
        
        if let refresh_token = authResponse.refresh_token {
            userDefault[.refresh_token] = refresh_token
        }
        
        userDefault[.expiration_date] = Date(timeIntervalSinceNow: TimeInterval(authResponse.expires_in))
    }
    
    private var accessToken:String?{
        return userDefault[.access_toke] as? String
    }
    
    private var refreshToken:String?{
        return userDefault[.refresh_token] as? String
    }
    
    private var tokenExpirationDate:Date?{
        return userDefault[.expiration_date] as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private func loadData<T:Codable> (endpoint: Endpoint) async ->  T{
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
        request.allHTTPHeaderFields = endpoint.header?.compactMapValues({$0})
        
        do {
            if let body = endpoint.body {
                
                var components = URLComponents()
                components.queryItems = body.compactMapValues({$0}).map({ (key: String, value: String) in
                    URLQueryItem(name: key, value: value)
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

