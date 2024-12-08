//
//  AppearanceSettings.swift
//  MyBuddyDemo
//
import Combine
import Foundation

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
