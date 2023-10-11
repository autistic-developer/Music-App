//
//  ExpandedPlayer.swift
//  MusicApp
//
//  Created by Lalit Vinde on 02/10/23.
//

import SwiftUI

struct ExpandedPlayer: View {
    let namespace: Namespace.ID
    @Binding var isPlaying:Bool
    let track: Track
    @Binding var expanded:Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.ultraThinMaterial)
            
                .clipShape(
                    
                    UnevenRoundedRectangle(cornerRadius: 16.w , corners: [.topLeft,.topRight])
                    
                    
                )
                .matchedGeometryEffect(id: "background", in: namespace)
                VStack(spacing: 0){
                    
                    CachedImage(photoURL: track.album.images[0].url)
                        .aspectRatio(contentMode: .fill)
                    
                        .matchedGeometryEffect(id: "image", in: namespace, isSource: true)
                        .frame(width: 335.w)

                        .mask{
                            RoundedRectangle(cornerRadius: 15.w)
                                .matchedGeometryEffect(id: "imageMask", in: namespace, isSource: true)
                        }
                    VStack(alignment: .leading){
                        Text(track.name)
                            .fontWeight(.bold)
                            .font(fontSize: 20.w)
                            .minimumScaleFactor(1)
                        
                            .matchedGeometryEffect(id: "name", in: namespace)
                            .frame(maxHeight: 20.w)
                            .lineLimit(1)
                        
                        
                        
                        Text(track.artists.first?.name ?? "")
                            .fontWeight(.regular)
                            .font(fontSize: 15.w)
                            .minimumScaleFactor(1)
                        
                        
                            .matchedGeometryEffect(id: "artist", in: namespace)

                            .frame(maxHeight: 15.w)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: 335.w, alignment:.leading)
                    .padding(.top, 15)
                    
                    PlayerSlider()
                        .padding(.top, 45)
                    PlayerController(isPlaying: $isPlaying)
                        .padding(.top, 40)
                    
                }
            
                .padding(.top, UIApplication.shared.keyWindow?.safeAreaInsets.top)
                .padding(.bottom,UIApplication.shared.keyWindow?.safeAreaInsets.bottom)

            
        }
        
        .padding(.bottom, 0.w)
        .transition(.scale(scale: 1))
        
        
    }
}

//#Preview {
//    ExpandedPlayer()
//}
