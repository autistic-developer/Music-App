//
//  UnevenRoundedRectangle.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//

import SwiftUI

struct UnevenRoundedRectangle: Shape,Animatable {
    var cornerRadius: CGFloat
    var corners: UIRectCorner = .allCorners
    var animatableData: CGFloat{
        get{ return cornerRadius}
        set{ cornerRadius = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
    
}

#Preview {
    
    UnevenRoundedRectangle(cornerRadius: 30.w, corners: [.topLeft, .bottomRight])
        .frame(width: 100.w, height: 100.w)
}
