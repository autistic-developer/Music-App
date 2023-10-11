//
//  TracksScrollViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 24/09/23.
//

import Foundation

extension LikedTracksScrollView{
    class ViewModel:ObservableObject{
        @Injected(\.httpClient) private var httpClient:HTTPClientBehavior
        @Published var tracks:[Track] = []
        
        let limit = 40
        var offset = 0
        func fetch(){
            Task{
                let endpoint:Endpoint = TracksEndPoint.savedTracks(limit: limit, offset: limit*offset)
                
                let response:Tracks = await httpClient.loadData(endpoint: endpoint)
                if response.next != nil{
                    offset += 1
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
