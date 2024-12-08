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
        userRepository.fetchAll { result in
            switch result {
            case .success(let users):
                let filtered = users.filter({ $0.uid != Constant.uid })
                self.state.cardModel = SwipeableCardsModel(cards: filtered)
                if let _current = users.first(where: { $0.uid == Constant.uid }) {
                    self.state.user.update(from: _current)
                }
                self.state.viewState = .done
            case .failure(let error):
                self.state.viewState = .error
            }
        }
    }
}
