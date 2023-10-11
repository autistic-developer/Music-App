//
//  BottomTabBar.swift
//  MusicApp
//
//  Created by Lalit Vinde on 20/09/23.
//

import SwiftUI

struct BottomTabBar: View {
    let tabs:[String] = [.IconsSet.home, .IconsSet.location,.IconsSet.like,.IconsSet.profile]
    @Namespace private var nameSpace
    @Binding var selectedTab: String
    var body: some View {
        Rectangle()
            .fill(Color(.ColorSet.secondary))
            .overlay{
                HStack(spacing:0){
                    ForEach(tabs, id: \.self){ tab in
                        Spacer()
                        
                        tabItem(tab)
                            .animation(.spring(response: 0.25,dampingFraction: 0.73), value: selectedTab)
                        Spacer()
                    }
                }
            }
            .frame(  height: 73.w)

        
    }
    
    func tabItem(_ tab:String) -> some View{
        Image(tab)
            .resizable()
            .scaledToFit()
            .frame(width: 24.w, height: 24.w)
            .foregroundStyle(
                selectedTab == tab ?
                Color(.ColorSet.primary) :
                        .gray.opacity(0.5)
            )
            .symbolVariant(
                selectedTab == tab ?
                /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/ : .none
            )
            .onTapGesture {
                selectedTab = tab
            }
            .frame(maxHeight: .infinity)
            .overlay(alignment: .top){
                if selectedTab == tab{
                    Capsule()
                        .trim(from: 0, to: 0.5)
                        .fill(Color(.ColorSet.primary))
                        .matchedGeometryEffect(id: "tab", in: nameSpace)
                        .frame(width: 23.w, height: 8.w)
                        .offset(y: -4.w)

                }
            }
        
        
        
    }
}

#Preview {
    struct Container : View{
        @State var selectedTab = "home"
        var body: some View{
            ZStack{
                BottomTabBar(selectedTab: $selectedTab)
            }
            .defaultBackground
        }
    }
    return Container()
}
