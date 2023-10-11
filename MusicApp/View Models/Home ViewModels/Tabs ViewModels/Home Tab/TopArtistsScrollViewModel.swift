//
//  TopArtistsScrollViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 27/09/23.
//

import Foundation
extension TopArtistsScrollView{
    class ViewModel : ObservableObject{
        @Injected(\.httpClient) var httpClient: HTTPClientBehavior
        @Published var artists:[Artist] = []
        let limit = 40
        var offset = 0
        func fetch(){
            Task{
                let endPoint = TopEndpoints.artists(limit: limit, offset: limit*offset)
                let response:TopArtists = await httpClient.loadData(endpoint: endPoint)
                if response.next != nil{
                    offset += 1
                }
                if artists.isEmpty || response.next != nil {
                    await MainActor.run{
                        artists.append(contentsOf: response.items)
                    }
                }
                
            }
        }
        
    }
}
