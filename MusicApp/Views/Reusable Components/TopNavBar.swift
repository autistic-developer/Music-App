//
//  TopNavBar.swift
//  MusicApp
//
//  Created by Lalit Vinde on 20/09/23.
//

import SwiftUI

struct TopNavBar<Content:View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var title: Content
    let onBackPress: () -> Void

    
    var body: some View {
        HStack{
            Circle()
                .fill(Color(.ColorSet.secondary))
                .brightness(colorScheme == .dark ? 0.1 : -0.1)
                .opacity(0.5)
                .overlay{
                    Image(.IconsSet.back)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(.ColorSet.contrast))
                        .frame(height: 12.5.w)
                }
                .frame(width: 32.w, height: 32.w)
                .onTapGesture(perform: onBackPress)
            Spacer()
            
            Image(.IconsSet.options)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color(.ColorSet.contrast))
                .frame(height: 18.w)
            
        }
        .overlay{
            HStack{
                title
            }
        }
        
        
    }
}
extension TopNavBar{
    init(title: Content = EmptyView(),  onBackPress:@escaping ()->Void = {} ){
        self.title = title
        self.onBackPress = onBackPress
    }
}
#Preview {
    TopNavBar()
}
