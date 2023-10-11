//
//  HomePage.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import SwiftUI

struct HomePage: View {
    @StateObject var environmentTrack = EnvironmentPlayer()
    let tabs:[String] = [.IconsSet.home, .IconsSet.location,.IconsSet.like,.IconsSet.profile]
    @State var selectedTab:String = .IconsSet.home
    init() {
        UITabBar.appearance().isHidden = true
        
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeTab()
                .ignoresSafeArea(edges: .bottom)
                .tag(tabs[0])
            
            Text("Loc")
                .ignoresSafeArea(edges: .bottom)
                .tag(tabs[1])
            
            LikesTab()
                .ignoresSafeArea(edges: .bottom)
                .tag(tabs[2])
            
            ProfileTab()
                .ignoresSafeArea(edges: .bottom)
                .tag(tabs[3])
        }
        
        .ignoresSafeArea()

        .animation(.spring(dampingFraction: 0.6), value: selectedTab)
        
        .onAppear{
            UIScrollView.appearance().isScrollEnabled = false
        }
      
        .safeAreaInset(edge: .bottom, spacing: 0){
            ZStack(alignment: .bottom){
                BottomTabBar(selectedTab: $selectedTab)
                    .zIndex(0)
                if let track = environmentTrack.tracks?[environmentTrack.idx]{
                    PlayerView(track: track)
//                        .transition(.move(edge: .bottom))
                    

                    
                }
                
            }
//                    .animation(.spring(duration: 0.3), value: environmentTrack.tracks)
//                    .animation(.spring(duration: 0.3), value: environmentTrack.idx)
            
        }
        

        
        .defaultBackground
        .ignoresSafeArea()
        .environmentObject(environmentTrack)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
        
        
        
    }
    
    
    
    
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
