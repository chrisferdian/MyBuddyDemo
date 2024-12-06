//
//  MainViewModel+State.swift
//  MyBuddyDemo

import Foundation
import UIKit

extension MainViewModel {
    struct State {
        var title: String = "Hello World!"
        var users: UserJSON?
        var selectedImage: UIImage?
        var isImagePickerPresented = false
    }

    enum Action {
        case fetchUsers
        case uploadImageProfile
    }

}

class UserJSON: Codable, ObservableObject {
    let uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
    var profileImageURL: String?
    
    init(uid: String?, email: String? = nil, phoneNumber: String? = nil, gender: GenderEnum? = nil, profileImageURL: String? = nil) {
        self.uid = uid
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.profileImageURL = profileImageURL
    }
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case gender = "ge"
        case profileImageURL = "profile_image_url"
    }
    
    var imageAsURL: URL? {
        guard let _url = profileImageURL else { return nil}
        return URL(string: _url)
    }
}
enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
