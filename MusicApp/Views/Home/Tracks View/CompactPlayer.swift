//
//  CompactPlayer.swift
//  MusicApp
//
//  Created by Lalit Vinde on 02/10/23.
//

import SwiftUI

struct CompactPlayer: View {
    @Environment(\.colorScheme) var colorScheme
    let namespace: Namespace.ID
    @Binding var isPlaying:Bool
    let track: Track
    @Binding var expanded:Bool
    var body: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
           
            .clipShape(
                
                UnevenRoundedRectangle(cornerRadius: 16.w , corners: [.topLeft,.topRight])
                    
                    
            )
            .matchedGeometryEffect(id: "background", in: namespace)

            .overlay{
                HStack(spacing:0){
                  
                    
                    CachedImage(photoURL: track.album.images[0].url)
                        .aspectRatio(contentMode: .fill)
                        
                        
                        .matchedGeometryEffect(id: "image", in: namespace, isSource: true)
                        
                        .frame(width: 50.w, height: 50.w)
                        .mask{
                            RoundedRectangle(cornerRadius: 15.w)
                                .matchedGeometryEffect(id: "imageMask", in: namespace, isSource: true)
                        }
                   
                        .padding(.horizontal,8.w)
                    
                    
                    VStack(alignment: .leading,spacing: 2.w) {
                        
                        Text(track.name)
                            .fontWeight(.bold)
                            .font(fontSize: 24.w)
                            .minimumScaleFactor(0.5)

                            .matchedGeometryEffect(id: "name", in: namespace)
                            .frame(maxHeight: 12.w)
                            .lineLimit(1)

                        
                        Text(track.artists.first?.name ?? "")
                            .fontWeight(.regular)

                            .font(fontSize: 20.w)
                            .minimumScaleFactor(0.45)


                            .matchedGeometryEffect(id: "artist", in: namespace)
                            .frame(maxHeight: 9.w)
                            .lineLimit(1)

                            

                    }

                    
                    
                    Spacer()
                    Group {
                        if isPlaying {
                            Image(.IconsSet.pause)
                                .resizable()
                                .scaledToFit()
                                .transition(.scale)
                                .frame(width: 8.75.w)
                                .transition(.scale)
                            
                            
                        } else {
                            Image(.IconsSet.play)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 11.w)
                                .transition(.scale)
                        }
                    }
                    .foregroundColor(.white)
                    .brightness(colorScheme == .dark ? 0 : -0.5)
                    
                    .frame(width: 28.w, height: 28.w)
                    
                    .onTapGesture {
                        withAnimation(.spring){
                            isPlaying.toggle()
                        }
                    }
                    .padding(.horizontal, 10.w)
                    .padding(.trailing, 5.w)
                    .transition(.opacity)
                }
            }
            .frame(height: 64.w)
            .padding(.bottom, 73.w)
            
            
            .transition(.scale(scale: 1))
        
           
        
    }
}

//#Preview {
//    CompactPlayer()
//}
