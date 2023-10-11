//
//  PlayerView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 30/09/23.
//

import SwiftUI

struct PlayerView: View {
    @Namespace var namespace
    @EnvironmentObject var environmentTrack:EnvironmentPlayer
    let track:Track
    @State var expanded = false
    var body: some View {
   
        Group{
            if expanded{
                ExpandedPlayer(namespace: namespace, isPlaying: $environmentTrack.isPlaying, track: track,  expanded: $expanded)
                    
//                    .onTapGesture {
//                        expanded.toggle()
//                    }
                
            }
            else{
                CompactPlayer(namespace: namespace, isPlaying: $environmentTrack.isPlaying, track: track, expanded: $expanded)
//                    .onTapGesture {
//                        expanded.toggle()
//                    }
            }
            
        }
        .onTapGesture {
            withAnimation(.spring) {
                expanded.toggle()
            }
        }
        
//        .animation(.spring(dampingFraction: 0.8), value: expanded)
        

        
    }
}



//#Preview {
//    PlayerView()
//}
