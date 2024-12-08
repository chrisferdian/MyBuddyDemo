//
//  CoordinatorView.swift
//  MyBuddyDemo
//
import SwiftUI

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
