//
//  SwiftUIMvvmArchApp.swift
//  SwiftUIMvvmArch
//
//  Created by John on 06/10/23.
//

import SwiftUI

@main
struct SwiftUIMvvmArchApp: App {
  
    let networkMonitor = NetworkMonitor()
    let networkViewPresenter = NetworkViewPresenter(networkMonitor: NetworkMonitor())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
                .environmentObject(networkViewPresenter)

        }
    }
}
