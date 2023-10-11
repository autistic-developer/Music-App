//
//  PlaylistScrollViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 22/09/23.
//

import Foundation
extension PlaylistScrollView{
    class ViewModel : ObservableObject {
        @Injected(\.httpClient) var httpClient: HTTPClientBehavior
        @Published var playlistModels: [Playlist] = []
        let limit = 40
        var offset = 0
        func fetch(userId:String){
            Task{
                let endpoint = PlaylistEndpoints.usersPlaylist(user_id: userId, limit: limit, offset: limit*offset)
                let playlists: Playlists = await httpClient.loadData(endpoint:endpoint)
                offset += 1
                await MainActor.run{
                    playlistModels.append(contentsOf: playlists.items)
                }
            }
        }
    }
}
