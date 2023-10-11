//
//  ExplorePlaylistViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 10/10/23.
//

import Foundation
import SwiftUI

extension ExplorePlaylistScrollView{
    class ViewModel : ObservableObject{
        @Injected(\.httpClient) var httpClient: HTTPClientBehavior
        @Published var tracks:[TrackWrapper] = []
        let limit = 40
        var offset = 0
        func fetch(playlist_id:String){
            Task{
                let endpoint = PlaylistEndpoints.playlistTracks(playlist_id: playlist_id,limit: limit, offset: limit*offset)
                let response:Tracks = await httpClient.loadData(endpoint: endpoint)
                if response.next != nil{
                    offset += 1
                }
                if tracks.isEmpty || response.next != nil {
                    await MainActor.run{
                        tracks.append(contentsOf: response.items.compactMap{  $0.track.preview_url != nil ? TrackWrapper(track: $0.track) : nil})
                    }
                }
                
            }
        }
    }
}
