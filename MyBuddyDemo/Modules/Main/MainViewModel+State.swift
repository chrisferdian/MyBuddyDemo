//
//  MainViewModel+State.swift
//  MyBuddyDemo

import Foundation

extension MainViewModel {
    struct State {
        var title: String = "Hello World!"
        var users: [UserJSON] = []
    }

    enum Action {
        case fetchUsers
    }
    
    struct UserJSON: Codable {
        let uid: String?
        let email: String?
        let phoneNumber: String?
        let gender: GenderEnum?
        
        enum CodingKeys: String, CodingKey {
            case uid = "uid"
            case email = "email"
            case phoneNumber = "phoneNumber"
            case gender = "ge"
        }
    }

    enum GenderEnum: Int, Codable {
        case female = 0
        case male = 1
    }
}
