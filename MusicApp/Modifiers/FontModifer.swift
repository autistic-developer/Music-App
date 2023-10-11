//
//  FontModifer.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import SwiftUI

struct FontModifer : ViewModifier{
    let fontSize:Double
    
//    var animatableData: Double {
//        get { fontSize }
//        set { fontSize = newValue }
//    }

    func body(content: Content) -> some View {
        content
            .font(.custom(String.FontSet.cascadia, size: fontSize))
    }
}

extension View{
    func font(fontSize:Double) -> some View{
        modifier(FontModifer(fontSize: fontSize))
    }
}
