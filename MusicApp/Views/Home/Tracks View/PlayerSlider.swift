//
//  PlayerSlider.swift
//  MusicApp
//
//  Created by Lalit Vinde on 01/10/23.
//
import SwiftUI

struct PlayerSlider: View {
    @EnvironmentObject var environmentTrack:EnvironmentPlayer
    @Environment(\.colorScheme) var colorScheme
    var progress : Double{
        get{
            let result = environmentTrack.currentTime/environmentTrack.endTime
            if result.isFinite{
                return result
            }
            else{
                return 0
            }
        }
        
    }
    

    var body: some View {
        VStack{
            ZStack(alignment: .leading) {
                backgroundCapsules
                
                trackingCapsule
                
                trackingCircle
            }
            
            HStack{
                Text(formattedTime(environmentTrack.currentTime))
                    .foregroundColor(colorScheme == .light ? Color(hex: 0x404040) : Color(hex: 0x878787))
                    .font(fontSize: 14.w)
                Spacer()
                Text(formattedTime(environmentTrack.endTime))
                    .foregroundColor(colorScheme == .light ? Color(hex: 0x404040) : Color(hex: 0x878787))
                    .font(fontSize: 14.w)

            }
            .padding(.top, 12.w)
            
        }
        .frame(width: 331.w)
        
    }

    private var backgroundCapsules: some View {
        
        Capsule()
            .fill(colorScheme == .light ? Color(hex: 0x000000, alpha: 0.3) : Color(hex: 0x888888, alpha: 0.4))
            .frame(height: 2.w)
    }
    
    private var trackingCapsule: some View {
        Capsule()
            .fill(colorScheme == .light ? Color(hex: 0x434343) : Color(hex: 0xB7B7B7))
            .frame(width: 331.w * progress, height: 4.w)
    }

    private var trackingCircle: some View {
        Circle()
            .fill(colorScheme == .light ? Color(hex: 0x434343) : Color(hex: 0xB7B7B7))
            .frame(width: 16.w, height: 16.w)
            .offset(x: 331.w * progress - 8.w)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        environmentTrack.isPlaying = false
                        Task{
                            await environmentTrack.seek(timeInSeconds: min(max(gesture.location.x / 331.w, 0), 1)*environmentTrack.endTime)
                        }
                    }
                    .onEnded({ _ in
                        environmentTrack.isPlaying = true
                    })
            )
    }
    
    func formattedTime(_ time: Double) -> String {
        if time.isNaN {return ""}
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
}



