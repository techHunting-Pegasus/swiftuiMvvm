//
//  AppDelegate.swift
//  SwiftUIMvvmArch
//
//  Created by John on 15/12/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FBSDKCoreKit
import WatchConnectivity
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//      FBSDKCoreKit.ApplicationDelegate.shared.application(
//                  application,
//                  didFinishLaunchingWithOptions: launchOptions
//              )
    FirebaseApp.configure()
    return true
  }
 
}
