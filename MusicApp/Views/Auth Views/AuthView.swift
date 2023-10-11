//
//  AuthView.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import SwiftUI

struct AuthView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        ZStack{
            Image(.IconsSet.app_icon)
                .resizable()
                .scaledToFit()
                .frame(width: 196.w, height: 59.w)
            Button{
                vm.isSheePresented=true
            }label: {
                butttonLabel
            }
            .sheet(isPresented: $vm.isSheePresented) {
                sheeView
            }
                
        }
        .ignoresSafeArea()
        
    }
    
    var sheeView: some View{
        ZStack{
            Color(.ColorSet.background).ignoresSafeArea()
            

            WebView(isPresented: $vm.isSheePresented , isLoading: $vm.isWebLoading, url: vm.signInURL())
                .padding(.vertical)
                .overlay{

                }
                .animation(.spring(), value: vm.isWebLoading)
                .opacity(vm.isWebLoading ? 0 : 1)
                .defaultBackground
            if vm.isWebLoading{
                ProgressView()
                    .transition(.opacity)
            }
                
        }
    }
    var butttonLabel: some View{
        RoundedRectangle(cornerRadius: 25.w)
            .fill(Color(.ColorSet.primary))
            .frame(width: 329.w, height: 80.w)
            .overlay{
                Text("**Get Started**")
                    .font(fontSize: 22.w)
                    .foregroundColor(.white)
                
            }
            .padding(.bottom, 40.w)
            
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
