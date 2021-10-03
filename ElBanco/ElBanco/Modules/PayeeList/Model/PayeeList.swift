//
//  PayeeList.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation

struct PayeeList: Decodable {
    let status: String?
    let data: [Payee]?
}

struct Payee: Decodable {
    let id, accountNo, accountHolderName: String?
}
