//
//  LikesTabViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import Foundation


extension AlbumsScrollView{
    class ViewModel: ObservableObject{
        @Injected(\.httpClient) var httpClient:HTTPClientBehavior
        @Published var albums:[Album] = []
        let limit = 40
        var offset = 0
        func fetch(){
            Task{
                let endpoint:Endpoint = AlbumsEndPoint.savedAlbums(limit: limit, offset: limit*offset)
                let response:SavedAlbums = await httpClient.loadData(endpoint: endpoint)
                if response.next != nil{
                    offset += 1
                }
                if albums.isEmpty || response.next != nil {
                    await MainActor.run{
                        albums.append(contentsOf: response.items.map{$0.album})
                    }
                }
               
            }
        }
    }
}
