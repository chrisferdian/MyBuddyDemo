//
//  ProfileViewModel.swift
//  MyBuddyDemo

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var state: State
    let storageRepositoy = FirebaseStorageRepositoryImpl()
    let userRepository = FirestoreRepositoryImpl<UserInfo>(collectionPath: "USERS")

    init(user: CurrentUser, appearance: AppearanceSettings) {
        self.state = State(user: user, appearanceSettings: appearance)
    }

    func send(_ action: Action) {
        switch action {
        case .saveAppearance(let selected):
            saveAppearanceSetting(selected)
        case .updateOnlineStatus(let isOn):
            state.user.isOnlineMode = isOn
        case .uploadImageProfile(let image):
            uploadProfileImage(image)
        }
    }
    
    private func saveAppearanceSetting(_ appearance: AppearanceSettings.Appearance) {
        UserDefaults.standard.set(appearance.rawValue, forKey: AppearanceSettings.UD_KEY)
    }
    
    // Upload profile image
    func uploadProfileImage(_ image: UIImage) {
        storageRepositoy.uploadImage(image) { result in
            switch result {
            case .success(let data):
                self.state.user.profileImageURL = data.absoluteString
                self.userRepository.update(self.state.user.toUserInfo, withID: Constant.uid) { result in
                    switch result {
                    case .success:
                        print("Success upload")
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
