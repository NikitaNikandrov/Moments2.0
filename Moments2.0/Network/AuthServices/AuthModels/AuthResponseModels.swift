//
//  AuthResponseModels.swift
//  Moments2.0
//
//  Created by Nikita Nikandrov on 23.03.2024.
//

import Foundation

struct AuthResponseModel: Codable {
    let code: String
    let success: Bool
    let data: DataClass
}

struct DataClass: Codable {
    let id: String
    let name: String
    let email: String
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let phone: String?
    let dateBirth: String?
    let token: String
    let avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case middleName = "middle_name"
        case phone
        case dateBirth = "date_birth"
        case token
        case avatar
    }
}

struct Avatar: Codable {
    let id: String
    let image: String
    let preview: [Preview]
}

struct Preview: Codable {
    let id: String
    let image: String
    let size: String
}
