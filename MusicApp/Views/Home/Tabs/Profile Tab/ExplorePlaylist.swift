//
//  ExplorePlaylist.swift
//  MusicApp
//
//  Created by Lalit Vinde on 09/10/23.
//

import SwiftUI

struct ExplorePlaylist: View {
    var namespace : Namespace.ID
    let playlistModel:Playlist
    @Binding var isPlaylistSelected:Bool
    var body: some View {
        VStack{
                CachedImage(photoURL: playlistModel.images[0].url)
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "imag\(playlistModel.id)", in: namespace, isSource: true)
                    .frame( width: UIScreen.main.bounds.width , height: 250.w)
                    .mask{
                        RoundedRectangle(cornerRadius: 15.w)
                            .matchedGeometryEffect(id: "imagMask\(playlistModel.id)", in: namespace, isSource: true)
                        
                    }
                    .overlay{
                        LinearGradient(colors: [Color(.ColorSet.background).opacity(0.6), .clear, ], startPoint: .top, endPoint: .bottom)
                    }
                    .zIndex(1)
                
                    

           
            VStack(alignment: .leading, spacing: 9.w){
                Text(playlistModel.name)
                    .fontWeight(.bold)
                    .font(fontSize: 20.w)
                    .minimumScaleFactor(1)
                
                    .matchedGeometryEffect(id: "name\(playlistModel.id)", in: namespace)
                    .frame(maxHeight: 20.w)
                    .lineLimit(1)
                
                Text(playlistModel.owner.display_name ?? "")
                    .fontWeight(.bold)
                    .font(fontSize: 14.w)
                    .minimumScaleFactor(1)
                
                    .matchedGeometryEffect(id: "owner\(playlistModel.id)", in: namespace)
                    .frame(maxHeight: 14.w)
                    .lineLimit(1)
                
            }
            .frame(maxWidth: 335.w, alignment:.leading)
            .zIndex(2)
  
            ExplorePlaylistScrollView(playlistId: playlistModel.id)
                .padding(.horizontal, 30.w)
                .overlay(alignment:.top){
                    Rectangle()
                            .fill(.linearGradient(.init(colors: [Color(.ColorSet.background), .clear]), startPoint: .top, endPoint: .bottom))
                            .frame(height: 15.w)
                            
                    .allowsHitTesting(false)
                    
                }


        }
        .defaultBackground
        .ignoresSafeArea()
        .safeAreaInset(edge: .top) {
            TopNavBar {
                withAnimation(.spring){
                    isPlaylistSelected.toggle()
                }
            }
            .padding(.horizontal, 30.w)
        }

       
    }
}

struct ExplorePlaylistScrollView: View {
    let playlistId:String
    @EnvironmentObject var environmentTrack : EnvironmentPlayer
    @StateObject var vm = ViewModel()
    @State var needPadding:Bool = false
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
                LazyVStack(spacing: 10.w){
                    ForEach(Array(vm.tracks.enumerated()), id:\.element.id){ index, model in
                        PlaylistTrackTile(model: model.track)
                            .onAppear{
                                if model.id == vm.tracks[vm.tracks.count - 1].id{
                                    vm.fetch(playlist_id: playlistId)
                                }
                            }
                            .onTapGesture {
                                Task{
                                    await environmentTrack.assignTracks(index, vm.tracks.map({$0.track}))
                                }
                                
                            }
                        
                    }
                }
                
                .padding(.bottom , 73.w + (environmentTrack.tracks != nil ? 64.w : 0) )
            
                

            
        }
        .onAppear{
            vm.fetch(playlist_id: playlistId)
        }
    }
}
struct PlaylistTrackTile: View {
    let model:Track
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            CachedImage(photoURL: model.album.images[0].url)
                .aspectRatio(contentMode: .fill)
                .frame(width: 58.w, height: 58.w)
                .mask{
                    RoundedRectangle(cornerRadius: 15.w)

                }
            
            VStack(alignment: .leading, spacing: 9.w){
                Text(model.name)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .font(fontSize: 13.5.w)
                
                Text(model.artists[0].name)
                    .lineLimit(1)
                    .font(fontSize: 12.w)
                
            }
            .padding(.top, 10.w)
            .padding(.leading, 20.w)
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(.ColorSet.contrast))
                .frame(width: 19.w)
                .frame(maxHeight: .infinity, alignment: .center)
                
            
        }
        

    }
}

#Preview {
    RecentsScrollView()
}
