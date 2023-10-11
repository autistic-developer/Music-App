//
//  EnvironmentTrack.swift
//  MusicApp
//
//  Created by Lalit Vinde on 02/10/23.
//

import Foundation
import AVFoundation
import Combine

actor EnvironmentPlayer : ObservableObject{
    @MainActor @Published var tracks:[Track]?
    @MainActor @Published var idx:Int = 0
    @MainActor @Published var isPlaying:Bool = false
    @MainActor @Published var currentTime: Double = 0.0
    @MainActor @Published var endTime: Double = 0.0
    private var player: AVPlayer?
    private var tracksSubscriber: Cancellable?   
    private var idxSubscriber: Cancellable?
    private var isPlayingSubscriber: Cancellable?

    
    
    init()  {
        
//        tracksSubscriber = $tracks.sink { items in
//            if let items{
//                Task{[weak self ] in
//                    if let i = await self?.idx , let preview_url = items[i].preview_url, let url = URL(string: preview_url){
//                        
//                        await self?.assignPlayer(url)
//                       
//                    }
//                }
//            }
//        }
        
        idxSubscriber = $idx.sink(receiveValue: { idx in
            Task{[weak self ] in
                await MainActor.run{[weak self ] in
                    self?.isPlaying = false
                    self?.endTime = 0
                    self?.currentTime = 0
                }
                
                if let track = await self?.tracks?[idx],
                    let preview_url = track.preview_url,
                    let url = URL(string: preview_url){
                    
                    await self?.assignPlayer(url)
                    await MainActor.run{[weak self ] in
                        self?.isPlaying = true
                    }

                }
            }
        })
        
        isPlayingSubscriber = $isPlaying.sink { val in
            if val{
                Task{
                    await self.play()
                }
            }
            else{
                Task{
                    await self.pause()
                }
            }
        }
        
    }
  
    func assignTracks(_ idx: Int,_ tracks: [Track]){
        Task{
            await MainActor.run{
                self.tracks = tracks
                self.idx = idx
                
            }
        }
    }
    private func assignPlayer(_ url: URL){
        if player != nil{
            player?.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        else{
            player = AVPlayer(url: url)
        }
        Task{
            updateProgressTime()
            await MainActor.run{
                self.isPlaying = true
            }
            
        }
    }
    
    private func updateProgressTime(){
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))

        player?.addPeriodicTimeObserver(forInterval: interval, queue: nil) { [weak self] time in
            Task{[weak self] in
                let endTime = await CMTimeGetSeconds(self?.player?.currentItem?.duration ?? .zero)
                await MainActor.run{[weak self] in
                    self?.endTime = endTime
                    self?.currentTime = CMTimeGetSeconds(time)
                }
            }
        }
    }
    private func play() async{
        await player?.play()
    }
    private func pause() async{
        await player?.pause()
    }
    func seek(timeInSeconds:Double) async{
        await player?.seek(to: CMTimeMakeWithSeconds(timeInSeconds, preferredTimescale: 1000))
    }
    nonisolated func nextTrack() {
        Task{
            await MainActor.run{
                if (idx+1 < tracks?.count ?? 0){
                    idx += 1
                }
            }
        }
    }
    nonisolated func previousTrack() {
        Task{
            await MainActor.run{
                if (0 <= self.idx-1){
                    idx -= 1
                }
            }
        }
    }
    
}
