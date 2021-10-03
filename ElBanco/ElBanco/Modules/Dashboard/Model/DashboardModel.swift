//
//  DashboardModel.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation

// MARK: - TransactionResponse Object
struct TransactionResponse: Decodable {
    let status: String
    let data: [Datas]
}

// MARK: - Data Object
struct Datas: Decodable {
    let id, type : String?
    let amount: Double
    let currency: String
    let from: From?
    let description: String?
    let date: String?
    let to: From?
    
    var transterStatus: String {
        guard let type = self.type, let name = from?.accountHolderName else { return ""}
        let lable = type == "receive" ? "Received from " : "Transer to "
        return lable + " \(name)"
    }
  
}

// MARK: - From Object
struct From: Decodable {
    let accountNo, accountHolderName: String
}

// MARK: - Account Balance Object
struct AccountBalance: Decodable {
    let status: String
    let balance: Double?
}

struct DashBoardModel: Decodable {
    let transaction: TransactionResponse?
    let balance: AccountBalance?
}
