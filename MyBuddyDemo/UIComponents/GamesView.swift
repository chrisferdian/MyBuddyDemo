//
//  GamesView.swift
//  MyBuddyDemo
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        HStack(spacing: -16) {
            GameCircleImage(imageName: "cod")
            GameCircleImage(imageName: "dota", hasBorder: true)
            Spacer()
            ZStack(alignment: .center) {
                LinearCircularGradientView()
                Image("voice")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 40, height: 40)
        }
        .padding(.vertical, 16)
    }
}

struct GameCircleImage: View {
    let imageName: String
    let hasBorder: Bool
    
    init(imageName: String, hasBorder: Bool = false) {
        self.imageName = imageName
        self.hasBorder = hasBorder
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .if(hasBorder) {
                $0.overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
            }
    }
}
struct LinearCircularGradientView: View {
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hex: "FFCBA0"), location: 0.0),
                        .init(color: Color(hex: "DD5789"), location: 0.51),
                        .init(color: Color(hex: "9B5BE6"), location: 1.0)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

// Extension for Hex Color
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
// Extension for conditional view modifiers
extension View {
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
