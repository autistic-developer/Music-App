//
//  AuthViewModel.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import Foundation

extension AuthView{
    class ViewModel : ObservableObject{
        @Published var isSheePresented: Bool = false
        @Published var isWebLoading: Bool = false
        @Injected(\.authService) var authService:AuthServicable
        func signInURL() -> URL?{
            authService.signInURL()
        }
        
    }
}
