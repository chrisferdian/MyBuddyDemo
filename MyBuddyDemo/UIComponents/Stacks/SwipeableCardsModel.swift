//
//  SwipeableCardsModel.swift
//  MyBuddyDemo
//

import SwiftUI

class SwipeableCardsModel<MODEL: ISwipeableCardModel>: ObservableObject {
    private var originalCards: [MODEL]
    @Published var unswipedCards: [MODEL]
    @Published var swipedCards: [MODEL]
    
    init(cards: [MODEL]) {
        self.originalCards = cards
        self.unswipedCards = cards
        self.swipedCards = []
    }
    
    func removeTopCard() {
        if !unswipedCards.isEmpty {
            guard let card = unswipedCards.first else { return }
            unswipedCards.removeFirst()
            swipedCards.append(card)
        }
    }
    
    func updateTopCardSwipeDirection(_ direction: SwipeDirection) {
        if !unswipedCards.isEmpty {
            unswipedCards[0].swipeDirection = direction
        }
    }
    
    func reset() {
        unswipedCards = originalCards
        swipedCards = []
    }
}
