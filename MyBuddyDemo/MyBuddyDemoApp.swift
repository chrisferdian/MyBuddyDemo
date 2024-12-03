//
//  MyBuddyDemoApp.swift
//  MyBuddyDemo
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      if let options = FirebaseOptions(contentsOfFile: AppEnvironment.googlePlist),
         FirebaseApp.app() == nil {
          print("Loading Firebase options from: \(AppEnvironment.googlePlist)")
          FirebaseApp.configure(options: options)
          FirebaseConfiguration.shared.setLoggerLevel(.max)
      } else {
          print("Failed to load Firebase options from: \(AppEnvironment.googlePlist)")
      }
    return true
  }
}

@main
struct MyBuddyDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
