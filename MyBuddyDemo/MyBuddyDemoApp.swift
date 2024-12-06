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
struct Constant {
    static let uid = "PLH8LLNSNGPAfVDe2Q2izcU1frl1"
}
@main
struct MyBuddyDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var user: UserJSON = UserJSON(uid: nil)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}

struct ContentView: View {
  @EnvironmentObject private var user: UserJSON
  
  var body: some View {
      MainView(user: user)
  }
}
