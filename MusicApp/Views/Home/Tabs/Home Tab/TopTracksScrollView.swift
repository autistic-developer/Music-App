//
//  TopTracksScrollView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 27/09/23.
//

import Foundation
import SwiftUI

struct TopTracksScrollView: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 16.w){
                ForEach(vm.tracks){ model in
                    TopTracksTile(model: model)
                        .onAppear{
                            if model.id == vm.tracks[vm.tracks.count - 1].id{
                                vm.fetch()
                            }
                        }
                }
            }.padding(.horizontal,30.w)
        }
        .frame(height: 170)
        .onAppear{
            vm.fetch()
        }
    }
    
}

struct TopTracksTile :View {
    let model: Track
    var body: some View {
        VStack{
            CachedImage(photoURL: model.album.images[0].url)
                .aspectRatio(contentMode: .fill)
                .frame(width: 135.w, height: 140.w)
                .mask{
                    RoundedRectangle(cornerRadius: 30.w)
                }
            Spacer()
            Text(model.name)
                .fontWeight(.semibold)
                .font(fontSize: 14.w)
                .lineLimit(1)
                .frame(width: 130.w)
        }
    }
}

#Preview {
    TopTracksScrollView()
}
