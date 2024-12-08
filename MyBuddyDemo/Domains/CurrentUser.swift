//
//  CurrentUser.swift
//  MyBuddyDemo
//
import Combine
import Foundation

class CurrentUser: ObservableObject {
    @Published var isOnlineMode: Bool
    private(set) var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
    var profileImageURL: String?
    @Published var username: String = ""
    var rates: [Double]?
    @Published var servicePrice: Double?

    init(user: UserInfo) {
        self.isOnlineMode = user.isOn
        uid = user.uid
        email = user.email
        phoneNumber = user.phoneNumber
        gender = user.gender
        profileImageURL = user.profileImageURL
        username = user.username ?? (user.gender == GenderEnum.male ? "Jon Doe" : "Jane Doe")
        rates = user.rates
        servicePrice = user.servicePrice
    }
    
    func update(from user: UserInfo) {
        self.isOnlineMode = user.isOn
        uid = user.uid
        email = user.email
        phoneNumber = user.phoneNumber
        gender = user.gender
        profileImageURL = user.profileImageURL
        username = user.username ?? (user.gender == GenderEnum.male ? "Jon Doe" : "Jane Doe")
        rates = user.rates
        servicePrice = user.servicePrice
    }
    
    var toUserInfo: UserInfo {
        UserInfo(
            uid: uid,
            email: email,
            phoneNumber: phoneNumber,
            gender: gender,
            profileImageURL: profileImageURL,
            username: username,
            rates: rates,
            isOn: isOnlineMode,
            price: servicePrice
        )
    }
    var imageAsURL: URL? {
        guard let _url = profileImageURL else { return nil}
        return URL(string: _url)
    }
}
