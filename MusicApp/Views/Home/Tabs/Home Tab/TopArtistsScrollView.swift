//
//  TopArtistsScrollView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 27/09/23.
//

import SwiftUI

struct TopArtistsScrollView: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 16.w){
                
                ForEach(vm.artists){ model in
                    TopArtistsTile(model: model)
                        .onAppear{
                            if model.id == vm.artists[vm.artists.count - 1].id{
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

struct TopArtistsTile :View {
    let model: Artist
    var body: some View {
        VStack{
            CachedImage(photoURL: model.images?[0].url)
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
    TopArtistsScrollView()
}
