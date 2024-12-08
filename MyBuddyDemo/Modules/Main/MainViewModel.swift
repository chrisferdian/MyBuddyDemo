//
//  MainViewModel.swift
//  MyBuddyDemo

import SwiftUI
import FirebaseFirestore

@MainActor
final class MainViewModel: ObservableObject {
    @Published var state: State
    
    let userRepository = FirestoreRepositoryImpl<UserInfo>(collectionPath: "USERS")
    
    init(user: CurrentUser) {
        self.state = State(user: user)
    }

    func send(_ action: Action) {
        switch action {
        case .fetchUsers:
            self.fetchUsers()
        case .filter:
            self.fetchUsersWithFilter()
        }
    }
    
    func fetchCurrentUser() {
        userRepository.fetch(byID: Constant.uid) { result in
            switch result {
            case .success(let user):
                self.state.user.update(from: user)
                self.state.viewState = .done
            case .failure(_):
                self.state.viewState = .error
            }
        }
    }
    
    func fetchUsers() {
        state.isFiltered = false
        userRepository.fetchAll { result in
            switch result {
            case .success(let users):
                self.state.cardModel = SwipeableCardsModel(cards: users)
                if let _current = users.first(where: { $0.uid == Constant.uid }) {
                    self.state.user.update(from: _current)
                }
                self.state.viewState = .done
            case .failure(_):
                self.state.viewState = .error
            }
        }
    }
    
    func fetchUsersWithFilter() {
        state.isFiltered = true
        userRepository.fetchFilteredUsers { result in
            switch result {
            case .success(let users):
                self.state.cardModel = SwipeableCardsModel(cards: users)
                if let _current = users.first(where: { $0.uid == Constant.uid }) {
                    self.state.user.update(from: _current)
                }
                self.state.viewState = .done
            case .failure(_):
                self.state.viewState = .error
            }
        }
    }
}
