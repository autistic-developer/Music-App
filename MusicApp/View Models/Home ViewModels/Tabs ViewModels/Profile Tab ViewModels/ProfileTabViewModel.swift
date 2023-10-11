//
//  ProfileTabViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//

import Foundation

extension ProfileTab{
    @MainActor
    class ViewModel : ObservableObject{
        let httpClient:HTTPClientBehavior = InjectedValues[HTTPClientBehaviorKey.self]
        @Published var model:User?
        init() {
            Task{
                self.model = await httpClient.loadData(endpoint: UserEndpoint.userProfile)
            }
        }
    }
}
