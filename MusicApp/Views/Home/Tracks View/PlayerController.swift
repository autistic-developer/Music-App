//
//  PlayerController.swift
//  MusicApp
//
//  Created by Lalit Vinde on 30/09/23.
//

import SwiftUI

import SwiftUI

struct PlayerController: View {
    @EnvironmentObject var environmentTrack:EnvironmentPlayer
    @Environment(\.colorScheme) var colorScheme
    @Binding var isPlaying:Bool
    
    var body: some View {
        HStack {
            loopButton
            backwardButton
            pauseButton
            forwardButton
            shuffleButton
        }
        .frame(width: 262.w)
    }
    
    private var loopButton: some View {
        Image(.IconsSet.loop)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.ColorSet.contrast))
            .brightness(colorScheme == .dark ? -0.5 : 0.3)
            .frame(width: 17.5.w, height: 19.38.w)
            .frame(width: 24.w, height: 24.w)
    }
    
    private var backwardButton: some View {
        Image(.IconsSet.backward)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.ColorSet.contrast))
            .brightness(colorScheme == .dark ? -0.2 : 0)
            .frame(width: 15.75.w, height: 14.63.w)
            .frame(width: 24.w, height: 24.w)
            .padding(.leading, 29.w)
            .opacity((0 <= environmentTrack.idx-1) ? 1 : 0.1)
            .onTapGesture {
                environmentTrack.previousTrack()
            }
    }
    
    private var pauseButton: some View {
        ZStack{
            Circle()
                .fill(Color(.ColorSet.primary))
                .frame(width: 72.w, height: 72.w)
            Group {
                if isPlaying {
                    Image(.IconsSet.pause)
                        .resizable()
                        .scaledToFit()
                        .transition(.scale)
                        .frame(width: 8.75.w)

                } else {
                    Image(.IconsSet.play)
                        .resizable()
                        .scaledToFit()
                        .transition(.scale)
                        .frame(width: 11.w)

                }
            }
            .foregroundColor(.white)
            .frame(width: 28.w, height: 28.w)
            
        }
        
        .frame(width: 72.w, height: 72.w)
        .onTapGesture {
            withAnimation(.spring){
                isPlaying.toggle()
            }
        }
        .padding(.leading, 16.w)

        
        
    }
    
    private var forwardButton: some View {
        Image(.IconsSet.forward)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.ColorSet.contrast))
            .brightness(colorScheme == .dark ? -0.2 : 0)
            .frame(width: 15.75.w, height: 14.63.w)
            .frame(width: 24.w, height: 24.w)
            .padding(.leading, 16.w)
            .opacity((environmentTrack.idx+1 < environmentTrack.tracks?.count ?? 0) ? 1 : 0.1)
            .onTapGesture {
                environmentTrack.nextTrack()
            }
    }
    
    private var shuffleButton: some View {
        Image(.IconsSet.shuffle)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.ColorSet.contrast))
            .brightness(colorScheme == .dark ? -0.5 : 0.3)
            .frame(width: 16.27.w, height: 17.38.w)
            .frame(width: 24.w, height: 24.w)
            .padding(.leading, 29.w)
    }
}


