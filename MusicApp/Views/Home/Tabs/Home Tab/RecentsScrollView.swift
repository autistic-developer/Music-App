//
//  ResentsScrollView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 25/09/23.
//

import SwiftUI

struct RecentsScrollView: View {
    @EnvironmentObject var environmentTrack : EnvironmentPlayer
    @StateObject var vm = ViewModel()
    @State var needPadding:Bool = false
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
                LazyVStack(spacing: 10.w){
                    ForEach(Array(vm.tracks.enumerated()), id:\.element.id){ index, model in
                        RecentTrackTile(model: model)
                            .onAppear{
                                if model.id == vm.tracks[vm.tracks.count - 1].id{
                                    vm.fetch()
                                }
                            }
                            .onTapGesture {
                                Task{
                                    await environmentTrack.assignTracks(index, vm.tracks)
                                }
                                
                            }
                        
                    }
                }
                
                .padding(.bottom , 73.w + (environmentTrack.tracks != nil ? 64.w : 0) )
            
                

            
        }
        .onAppear{
            vm.fetch()
        }
    }
}
struct RecentTrackTile: View {
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
