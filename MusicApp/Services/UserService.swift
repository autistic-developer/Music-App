//
//  UserService.swift
//  MusicApp
//
//  Created by Lalit Vinde on 17/09/23.
//

import Foundation

actor UserService{
    @Injected(\.httpClient) var httpClient: HTTPClientBehavior
    func getCurrentUser() async -> User{
        let endpoint = UserEndpoint.userProfile
        let user:User = await httpClient.loadData(endpoint: endpoint)
        return user
    }
}
