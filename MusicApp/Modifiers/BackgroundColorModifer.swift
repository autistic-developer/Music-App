//
//  BackgroundColorModifer.swift
//  MusicApp
//
//  Created by Lalit Vinde on 20/09/23.
//

import Foundation
import SwiftUI

struct BackgroundColorModifer : ViewModifier{
    func body(content: Content) -> some View {
        ZStack{
            Color(.ColorSet.background)
                .ignoresSafeArea()
            content
        }

            
    }
}

extension View{
    var defaultBackground: some View{
        modifier(BackgroundColorModifer())
    }
}
