//
//  LoginRequest.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation

struct LoginRequest: Encodable {
    let username, password :  String
}

struct LoginResponse: Decodable {
    let status, token: String?
}
