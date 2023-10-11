//
//  PlaylistScrollView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 22/09/23.
//

import SwiftUI

struct PlaylistScrollView: View {
    var namespace:Namespace.ID
    @EnvironmentObject var environmentTrack : EnvironmentPlayer
    @Binding var selectedPlaylist:Playlist?
    @Binding var isPlaylistSelected:Bool
    @StateObject var vm : ViewModel = ViewModel()
    let userId: String
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(spacing: 10.w){
                ForEach(vm.playlistModels){ model in
                    
                    PlaylistTile(namespace: namespace, model: model, isSelected: isPlaylistSelected && selectedPlaylist == model )
                        .transition(.scale(scale: 1))
                        .onAppear{
                            if model.id == vm.playlistModels[vm.playlistModels.count - 1].id{
                                vm.fetch(userId: userId)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring){
                                selectedPlaylist = model
                                isPlaylistSelected = true
                            }
                        }
                    
                    
                    
                }
            }
            .padding(.horizontal, 30.w)
            .padding(.bottom , 73.w + (environmentTrack.tracks != nil ? 64.w : 0) )

            
            
        }
        .onAppear{
            selectedPlaylist = nil
            vm.fetch(userId: userId)
        }
        
    }
}

struct PlaylistTile:View {
    var namespace:Namespace.ID
    let model:Playlist
    let isSelected:Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            if !isSelected{
                CachedImage(photoURL: model.images[0].url)
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "imag\(model.id)", in: namespace, isSource: true)
                    .frame(width: 58.w, height: 58.w)
                    .mask{
                        RoundedRectangle(cornerRadius: 15.w)
                            .matchedGeometryEffect(id: "imagMask\(model.id)", in: namespace, isSource: true)
                        
                    }
                    .transition(.scale(scale:1,anchor: .center))

                VStack(alignment: .leading, spacing: 9.w){
                    Text(model.name)
                        .fontWeight(.bold)
                        .font(fontSize: 13.5.w*1/0.5)
                        .minimumScaleFactor(0.5)
                    
                        .matchedGeometryEffect(id: "name\(model.id)", in: namespace)
                        .frame(maxHeight: 13.5.w)
                        .lineLimit(1)
                    
                    Text(model.owner.display_name ?? "")
                        .fontWeight(.regular)
                        .font(fontSize: 12.w*1/0.5)
                        .minimumScaleFactor(0.5)
                    
                        .matchedGeometryEffect(id: "owner\(model.id)", in: namespace)
                        .frame(maxHeight: 12.w)
                        .lineLimit(1)
                    
                }
                .padding(.top, 10.w)
                .padding(.leading, 20.w)
                Spacer()
                
            }
        }
        .frame(height: 58.w)

        
    }
}
//#Preview {
//    PlaylistScrollView(userId: "")
//}
