//
//  MainViewModel.swift
//  MyBuddyDemo

import SwiftUI
import FirebaseFirestore

@MainActor
final class MainViewModel: ObservableObject {
    @Published var state: State
    
    let userRepository = FirestoreRepositoryImpl<UserInfo>(collectionPath: "USERS")
    let storageRepositoy = FirebaseStorageRepositoryImpl()
    
    init(user: CurrentUser) {
        self.state = State(user: user)
    }

    func send(_ action: Action) {
        switch action {
        case .fetchUsers:
            self.fetchUsers()
        case .uploadImageProfile:
            if let image = state.selectedImage {
                uploadProfileImage(image)
            }
        }
    }
    
    func fetchCurrentUser() {
        userRepository.fetch(byID: Constant.uid) { result in
            switch result {
            case .success(let user):
                self.state.user.user = user
                self.state.viewState = .done
            case .failure(let failure):
                self.state.viewState = .error
            }
        }
    }
    
    func fetchUsers() {
        userRepository.fetchAll { result in
            switch result {
            case .success(let users):
                self.state.cardModel = SwipeableCardsModel(cards: users)
                if let _current = users.first(where: { $0.uid == Constant.uid }) {
                    self.state.user = .init(user: _current)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Upload profile image
    func uploadProfileImage(_ image: UIImage) {
        storageRepositoy.uploadImage(image) { result in
            switch result {
            case .success(let data):
//                self.state.users = data.absoluteString
                self.userRepository.update(self.state.user.user, withID: Constant.uid) { result in
                    switch result {
                    case .success:
                        print("success")
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
