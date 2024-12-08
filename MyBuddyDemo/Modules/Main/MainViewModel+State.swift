//
//  MainViewModel+State.swift
//  MyBuddyDemo

import Foundation
import UIKit

extension MainViewModel {
    struct State {
        var title: String = "Hello World!"
        var user: CurrentUser
        var users: [UserInfo] = []
        var selectedImage: UIImage?
        var isImagePickerPresented = false
        var cardModel: SwipeableCardsModel<UserInfo>?
        var viewState: ViewState = .loading
        var isFiltered: Bool = false
    }

    enum Action {
        case fetchUsers
        case filter
    }

    enum ViewState {
        case loading
        case done
        case error
    }
}
