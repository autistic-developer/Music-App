//
//  LikesTab.swift
//  MusicApp
//
//  Created by Lalit Vinde on 23/09/23.
//

import SwiftUI

struct LikesTab: View {
    var body: some View {
        VStack(spacing: 0){
            Text("**Album**")
                .font(fontSize: 16.w)
                .padding(.horizontal, 30.w)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical,18.w)
            AlbumsScrollView()
                .overlay{
                    HStack{
                        Rectangle()
                            .fill(.linearGradient(.init(colors: [Color(.ColorSet.background), .clear]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 15.w)
                        Spacer()
                        Rectangle()
                            .fill(.linearGradient(.init(colors: [.clear,Color(.ColorSet.background)]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 15.w)
                    }
                    .allowsHitTesting(false)
                }
                .padding(.bottom,26.w)

            Text("**Songs**")
                .font(fontSize: 16.w)
                .padding(.horizontal, 30.w)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom,18.w)
           LikedTracksScrollView()
                .overlay(alignment:.top){
                    Rectangle()
                            .fill(.linearGradient(.init(colors: [Color(.ColorSet.background), .clear]), startPoint: .top, endPoint: .bottom))
                            .frame(height: 15.w)
                            
                    .allowsHitTesting(false)
                }
                .padding(.horizontal, 30.w)

        }
        
    }
}



#Preview {
    LikesTab()
}
