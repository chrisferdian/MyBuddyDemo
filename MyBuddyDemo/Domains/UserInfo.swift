//
//  UserInfo.swift
//  MyBuddyDemo
//

import Foundation

struct UserInfo: Codable, ISwipeableCardModel {
    var swipeDirection: SwipeDirection = .none
    var id: UUID = UUID()
    let uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
    var profileImageURL: String?
    var username: String?
    var rates: [Double]?
    var isOn: Bool = false
    var servicePrice: Double?
    var rating: Double?
    var lastActive: Date?

    init(uid: String?, email: String? = nil, phoneNumber: String? = nil, gender: GenderEnum? = nil, profileImageURL: String? = nil, username: String? = nil, rates: [Double]? = nil, isOn: Bool, price: Double? = 0, rating: Double? = 0, lastActive: Date? = nil) {
        self.uid = uid
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.profileImageURL = profileImageURL
        self.username = username
        self.rates = rates
        self.isOn = isOn
        self.servicePrice = price
        self.rating = rating
        self.lastActive = lastActive
    }
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case gender = "ge"
        case profileImageURL = "profile_image_url"
        case username = "un"
        case rates
        case isOn
        case servicePrice = "sp"
        case rating
        case lastActive = "la"
    }
    var imageAsURL: URL? {
        guard let _url = profileImageURL else { return nil}
        return URL(string: _url)
    }
    
    var rateAvg: Double {
        guard !(rates ?? []).isEmpty else { return 0 } // Handle empty array
        let sum = (rates ?? []).reduce(0, +)
        let average = sum / Double(rates?.count ?? 0)
        return Double(round(average * 10) / 10) // Round to 1 decimal place
    }
    
    var priceFormatted: String {
        return String(servicePrice ?? 0)
    }
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
