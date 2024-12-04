//
//  MainViewModel.swift
//  MyBuddyDemo

import SwiftUI
import FirebaseFirestore

@MainActor
final class MainViewModel: ObservableObject {
    @Published var state: State
    
    let userRepository = FirestoreRepositoryImpl<MainViewModel.UserJSON>(collectionPath: "USERS")

    init() {
        self.state = State()
    }

    func send(_ action: Action) {
        switch action {
        case .fetchUsers:
            self.fetchUsers()
        }
    }
    
    func fetchUsers() {
        userRepository.fetchAll { result in
            switch result {
            case .success(let users):
                self.state.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
