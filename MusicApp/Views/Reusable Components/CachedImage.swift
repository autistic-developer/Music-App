//
//  CachedImage.swift
//  MusicApp
//
//  Created by Lalit Vinde on 21/09/23.
//


import SwiftUI
import Kingfisher

struct CachedImage<Content:View>: View {
    
    let photoURL:URL?
    @ViewBuilder var placeholder : Content
    
    var body: some View {
        
        KFImage(photoURL)
            .placeholder { progress in
                placeholder

            }
            .fade(duration: 0.25)
            .resizable()

    }
}
extension CachedImage{
    init(photoURL: URL?, placeholder: Content = EmptyView()) {
        self.photoURL = photoURL
        self.placeholder = placeholder
    }
}

#Preview {
    CachedImage(photoURL: URL(string: "https://t4.ftcdn.net/jpg/05/47/97/81/360_F_547978128_vqEEUYBr1vcAwfRAqReZXTYtyawpgLcC.jpg") )
}

