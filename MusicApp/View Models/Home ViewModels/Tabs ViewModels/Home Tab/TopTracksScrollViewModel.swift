//
//  TopTracksScrollViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 27/09/23.
//

import Foundation

extension TopTracksScrollView{
    class ViewModel : ObservableObject{
        @Injected(\.httpClient) var httpClient:HTTPClientBehavior
        @Published var tracks:[Track] = []
        let limit = 40
        var offset = 0
        func fetch(){
            Task{
                let endPoint = TopEndpoints.tracks(limit: limit, offset: limit*offset)
                let response:TopTracks = await httpClient.loadData(endpoint: endPoint)
                if response.next != nil{
                    offset += 1
                }
                if tracks.isEmpty || response.next != nil {
                    await MainActor.run{
                        tracks.append(contentsOf: response.items.compactMap{ $0.preview_url != nil ? $0 : nil})
                    }
                }
                
            }
        }
        
    }
}
