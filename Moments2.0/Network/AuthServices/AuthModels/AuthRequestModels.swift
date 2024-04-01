//
//  AuthRequestModels.swift
//  Moments2.0
//
//  Created by Nikita Nikandrov on 23.03.2024.
//

import Foundation

struct LoginRequestModel {
    let email: String
    let password: String
}

struct RegistrationRequestModel {
    let name: String
    let email: String
    let password: String
}
