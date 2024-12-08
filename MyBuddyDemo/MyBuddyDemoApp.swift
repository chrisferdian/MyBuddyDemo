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

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinatorImpl = AppCoordinatorImpl()
    @StateObject private var user: CurrentUser = CurrentUser(user: .init(uid: Constant.uid, isOn: false))
    @StateObject private var appearanceSettings = AppearanceSettings()

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.home(user))
                .navigationTitle(AppEnvironment.productName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if user.uid != nil {
                            Button(action: {
                                appCoordinator.push(.profile(user, appearanceSettings))
                            }) {
                                AsyncImage(url: user.imageAsURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 40, maxHeight: 40)
                                        .cornerRadius(10)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .cornerRadius(10)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                        )
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if user.uid != nil {
                            Circle()
                                .fill(user.isOnlineMode ? .green : .red)
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
        .environmentObject(user)
        .environmentObject(appearanceSettings)
        .preferredColorScheme(resolveColorScheme(appearanceSettings.selectedAppearance))

    }
    
    // Resolve the color scheme based on user selection
    private func resolveColorScheme(_ appearance: AppearanceSettings.Appearance) -> ColorScheme? {
        switch appearance {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

class AppearanceSettings: ObservableObject {
    static let UD_KEY = "AppearanceSetting"
    
    @Published var selectedAppearance: Appearance = .system

    init() {
        // Load saved setting
        self.selectedAppearance = loadAppearanceSetting()
    }
    enum Appearance: String, CaseIterable, Equatable {
        case light = "Light"
        case dark = "Dark"
        case system = "System"
    }
    func loadAppearanceSetting() -> Appearance {
        let rawValue = UserDefaults.standard.string(forKey: AppearanceSettings.UD_KEY) ?? Appearance.system.rawValue
        return Appearance(rawValue: rawValue) ?? .system
    }
}
