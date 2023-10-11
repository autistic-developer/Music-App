//
//  TestView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 28/09/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.blue // Background color
            
            VStack {
                // Content here
                
                Spacer() // Push content to the top
                
                // Top safe area color
                Color.red
                    .ignoresSafeArea(edges: .top) // Ignore the safe area only for the top edge
                    .frame(height: 0) // Set the height to 0 to make it cover only the safe area
            }
        }
    }
}

#Preview {
    TestView()
}
