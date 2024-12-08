//
//  ProfileViewModel+State.swift
//  MyBuddyDemo

import SwiftUI

extension ProfileViewModel {
    struct State {
        var title: String = "Hello World!"
        var user: CurrentUser
        var appearanceSettings: AppearanceSettings
    }

    enum Action {
        case saveAppearance(AppearanceSettings.Appearance)
        case updateOnlineStatus(Bool)
        case uploadImageProfile(UIImage)
    }
}
