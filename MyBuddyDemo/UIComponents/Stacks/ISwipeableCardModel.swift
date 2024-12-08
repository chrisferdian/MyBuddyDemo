//
//  ISwipeableCardModel.swift
//  MyBuddyDemo
//

import Foundation

protocol ISwipeableCardModel: Identifiable, Equatable {
    var swipeDirection: SwipeDirection { get set }
    var id: UUID { get }
}
