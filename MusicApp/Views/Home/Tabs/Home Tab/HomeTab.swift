//
//  HomeTab.swift
//  MusicApp
//
//  Created by Lalit Vinde on 25/09/23.
//

import SwiftUI

struct HomeTab: View {
    @State var isVisible:Bool = false
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(spacing:0,pinnedViews: [.sectionHeaders]){
                Text("**Top Artists**")
                    .font(fontSize: 16.w)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical,18.w)
                    .padding(.horizontal, 30.w)
                
                TopArtistsScrollView()
                    .edgeFade()
                    .padding(.bottom,26.w)
                
                Text("**Top Tracks**")
                    .font(fontSize: 16.w)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom,18.w)
                    .padding(.horizontal, 30.w)
                
                TopTracksScrollView()
                    .edgeFade()
                    .padding(.bottom,26.w)
                
                Section{
                    RecentsScrollView()
                        .padding(.horizontal, 30.w)
                    
                    
                }
            header:
                {
                    
                    Text("**Recently Played**")
                        .font(fontSize: 16.w)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom,18.w)
                        .padding(.horizontal, 30.w)
                    
                        .background{
                            GeometryReader { geometry in
                                Color(.ColorSet.background)
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: (geometry.frame(in: .named("scroll")).minY - 1.w) <= 0)
                            }
                        }
                    
                    
                        .overlay(alignment:.bottom){
                            Rectangle()
                                .fill(.linearGradient(.init(colors: [Color(.ColorSet.background), .clear]), startPoint: .top, endPoint: .bottom))
                                .frame(height: 15.w)
                                .alignmentGuide(.bottom, computeValue: { d in
                                    d[.top]
                                })
                                .allowsHitTesting(false)
                        }
                    
                    
                    
                }
                
                
                
            }
            
            
            
        }
        .coordinateSpace(name: "scroll")
        
        
        
        .safeAreaInset(edge: .top, spacing: 0){
            Rectangle()
                .frame(width: 0, height: 0)
                .frame(maxWidth: .infinity)
                .background(isVisible ? Color(.ColorSet.background) :  Color.clear)
            
        }
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            self.isVisible = value
        }
    }
}

#Preview {
    HomeTab()
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
