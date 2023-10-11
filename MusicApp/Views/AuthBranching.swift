//
//  AuthBranching.swift
//  MusicApp
//
//  Created by Lalit Vinde on 18/09/23.
//

import SwiftUI


struct AuthBranching: View {
    @AppStorage(UserDefaultsManager.Keys.access_toke.rawValue) var access_token : String?
    var body: some View {
        Group {
            if access_token == nil{
                AuthView()
            }
            else{
                HomePage()
            }
        }
    }
}

struct AuthBranching_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthBranching()
    }
}
