//
//  MainViewModel.swift
//  MyBuddyDemo

import SwiftUI
import FirebaseFirestore

@MainActor
final class MainViewModel: ObservableObject {
    @Published var state: State
    
    let userRepository = FirestoreRepositoryImpl<UserJSON>(collectionPath: "USERS")
    let storageRepositoy = FirebaseStorageRepositoryImpl()
    
    init(user: UserJSON) {
        self.state = State(users: user)
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
    
    func fetchUsers() {
        userRepository.fetchAll { result in
            switch result {
            case .success(let users):
                self.state.users = users.first
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
                self.state.users?.profileImageURL = data.absoluteString
                self.userRepository.update(self.state.users!, withID: Constant.uid) { result in
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
