//
//  File.swift
//  MusicApp
//
//  Created by Lalit Vinde on 25/09/23.
//

import Foundation

extension RecentsScrollView{
    class ViewModel : ObservableObject{
        @Injected(\.httpClient) var httpClient: HTTPClientBehavior
        @Published var tracks:[Track] = []
        let limit = 40
        var after: Int?
        func fetch(){
            Task{
                let endpoint = RecentTracksEndPoint.resentTracks(limit: limit, after: after)
                let response:RecentlyPlayedTracks = await httpClient.loadData(endpoint: endpoint)
                if response.next != nil{
                    after = response.cursors != nil ? Int(response.cursors!.after) : nil
                }
                if tracks.isEmpty || response.next != nil {
                    await MainActor.run{
                        tracks.append(contentsOf: response.items.compactMap{ $0.track.preview_url != nil ? $0.track : nil})
                    }
                }
            }
        }
    }
}
