//
//  Pages.swift
//  MyBuddyDemo
//
//  Created by Indo Teknologi Utama on 06/12/24.
//
import UIKit

enum Pages: Identifiable, Hashable {
    static func == (lhs: Pages, rhs: Pages) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.profile, .profile):
            return true
        default:
            return false
        }
    }
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home, .profile:
            hasher.combine("user")
        }
    }
    
    case home(CurrentUser)
    case profile(CurrentUser)
    
    var id: Self { return self }
}

enum Sheet: Identifiable, Hashable {
    case photoPicker((UIImage) -> Void)
        
    var id: Self { return self }
    
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        switch (lhs, rhs) {
        case (.photoPicker, .photoPicker):
            return true
        }
    }
    func hash(into hasher: inout Hasher) {
        switch self {
        case .photoPicker:
            hasher.combine("imagePicker")
        }
    }
}

enum FullScreenCover: Identifiable, Hashable {
    var id: Self { return self }
    case edit
}
extension FullScreenCover {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .edit:
            hasher.combine("edit")
        }
    }
    
    // Conform to Equatable
    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        switch (lhs, rhs) {
        case (.edit, .edit):
            return true
        }
    }
}
