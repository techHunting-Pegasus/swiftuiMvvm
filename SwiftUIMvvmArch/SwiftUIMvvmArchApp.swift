//
//  SwiftUIMvvmArchApp.swift
//  SwiftUIMvvmArch
//
//  Created by John on 06/10/23.
//

import SwiftUI

@main
struct SwiftUIMvvmArchApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let networkMonitor = NetworkMonitor()
    let networkViewPresenter = NetworkViewPresenter(networkMonitor: NetworkMonitor())
    let SocialLoginManager = AuthenticationManager()

    var body: some Scene {
        WindowGroup {
        
                ContentView()
                    .environmentObject(networkMonitor)
                    .environmentObject(networkViewPresenter)
                    .environmentObject(SocialLoginManager)
       
       
        }
    }
}
