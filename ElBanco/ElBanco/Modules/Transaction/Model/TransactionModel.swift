//
//  TransactionRequestModel.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation

struct TransactionRequest:  Encodable {
    let recipientAccountNo, date, description: String?
    let amount: Double?
}

struct TransactionResponseModel: Decodable {
    let status: String?
    let data: TransactionData?
}
struct TransactionData: Decodable {
    let id, recipientAccountNo,date,description: String?
    let amount: Double?
}
