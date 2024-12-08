//
//  StackCardView.swift
//  MyBuddyDemo
//
import SwiftUI

struct StackCardView<Content: View>: View {
    @ViewBuilder
    private let content: Content
    
    var swipeDirection: SwipeDirection = .none
    var size: CGSize
    var dragOffset: CGSize
    var isTopCard: Bool
    var isSecondCard: Bool

    init(@ViewBuilder contentBuilder: @escaping () -> Content,
         size: CGSize,
         dragOffset: CGSize,
         isTopCard: Bool,
         isSecondCard: Bool
    ) {
        self.content = contentBuilder()
        self.size = size
        self.dragOffset = dragOffset
        self.isTopCard = isTopCard
        self.isSecondCard = isSecondCard
    }
    
    var body: some View {
        content
            .frame(width: size.width * (isTopCard ? 0.8 : 0.85), height: size.height * (isTopCard ? 0.8 : 0.85))
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: isTopCard ? getShadowColor() : (isSecondCard && dragOffset.width != 0 ? Color.gray.opacity(0.2) : Color.gray.opacity(0.2)), radius: 10, x: 0, y: 3)
            .padding(.bottom, 24)
    }
    
    private func getShadowColor() -> Color {
        if dragOffset.width > 0 {
            return Color.green.opacity(0.5)
        } else if dragOffset.width < 0 {
            return Color.red.opacity(0.5)
        } else {
            return Color.gray.opacity(0.2)
        }
    }
}
