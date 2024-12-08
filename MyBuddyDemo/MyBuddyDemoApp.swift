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
    @StateObject private var user: CurrentUser = CurrentUser(user: .init(uid: Constant.uid))

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(user)
        }
    }
}

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinatorImpl = AppCoordinatorImpl()
    @EnvironmentObject
    private var user: CurrentUser

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.home(user))
                .navigationTitle(AppEnvironment.productName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            appCoordinator.push(.profile(user))
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                        }
                    }
                }
                .navigationDestination(for: Pages.self) { screen in
                    appCoordinator.build(screen)
                }
                .sheet(item: $appCoordinator.sheet) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
                    appCoordinator.build(fullScreenCover)
                }
        }
        .environmentObject(appCoordinator)
    }
}
