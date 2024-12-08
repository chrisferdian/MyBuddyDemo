//
//  SwipeableCardsView.swift
//  MyBuddyDemo
//
import SwiftUI

struct SwipeableCardsView<SwipeableInfo: ISwipeableCardModel>: View {
    

    private let contentBuilder: (SwipeableInfo) -> AnyView

    @ObservedObject var model: SwipeableCardsModel<SwipeableInfo>
    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0
    
    private let swipeThreshold: CGFloat = 100.0
    private let rotationFactor: Double = 35.0
    
    var action: (SwipeableCardsModel<SwipeableInfo>) -> Void
    
    init(ViewBuilder contentBuilder: @escaping (SwipeableInfo) -> AnyView,
         model: SwipeableCardsModel<SwipeableInfo>, action: @escaping (SwipeableCardsModel<SwipeableInfo>) -> Void) {
        self.contentBuilder = contentBuilder
        self.model = model
        self.action = action
    }
    var body: some View {
        GeometryReader { geometry in
            if model.unswipedCards.isEmpty && model.swipedCards.isEmpty {
                emptyCardsView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else if model.unswipedCards.isEmpty {
                swipingCompletionView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                ZStack {
                    Color.white.ignoresSafeArea()
                    let reversedCards = Array(model.unswipedCards.reversed())
                    ForEach(reversedCards) { card in
                        let isTop = card == model.unswipedCards.first
                        let isSecond = card == model.unswipedCards.dropFirst().first
                        
                        renderCard(card, isTop: isTop, isSecond: isSecond, geometry: geometry)
                    }
                }
                .padding()
            }
        }
    }
    func renderCard(_ card: SwipeableInfo, isTop: Bool, isSecond: Bool, geometry: GeometryProxy) -> some View {
        StackCardView(contentBuilder: {
            contentBuilder(card)
        }, size: geometry.size, dragOffset: dragState, isTopCard: isTop, isSecondCard: isSecond)
        .offset(x: isTop ? dragState.width : 0)
        .rotationEffect(.degrees(isTop ? Double(dragState.width) / rotationFactor : 0))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.dragState = gesture.translation
                    self.cardRotation = Double(gesture.translation.width) / rotationFactor
                }
                .onEnded { _ in
                    if abs(self.dragState.width) > swipeThreshold {
                        let swipeDirection: SwipeDirection = self.dragState.width > 0 ? .right : .left
                        model.updateTopCardSwipeDirection(swipeDirection)
                        
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.dragState.width = self.dragState.width > 0 ? 1000 : -1000
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.model.removeTopCard()
                            self.dragState = .zero
                        }
                    } else {
                        withAnimation(.spring()) {
                            self.dragState = .zero
                            self.cardRotation = 0
                        }
                    }
                }
        )
        .animation(.easeInOut, value: dragState)
    }
    var emptyCardsView: some View {
        VStack {
            Text("No Cards")
                .font(.title)
                .padding(.bottom, 20)
                .foregroundStyle(.gray)
        }
    }
    
    var swipingCompletionView: some View {
        VStack {
            Text("Finished Swiping")
                .font(.title)
                .padding(.bottom, 20)
            
            Button(action: {
                action(model)
            }) {
                Text("Reset")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
