//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Lalit Vinde on 12/09/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
}


@main
struct MusicAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            AuthBranching()
        }
    }
}
