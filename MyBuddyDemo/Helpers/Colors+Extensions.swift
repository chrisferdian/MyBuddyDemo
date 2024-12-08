//
//  Colors+Extensions.swift
//  MyBuddyDemo
//

import SwiftUI


extension Color {
    static let textPrimary = Color("colorTextPrimary")
    static let textSecondary = Color("colorTextSecondary")
}
extension String {
    static func placeholder(length: Int) -> String {
        String(Array(repeating: "X", count: length))
    }
}
