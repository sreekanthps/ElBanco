//
//  PayeeListViewModel.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation

class PayeeListViewModel {
    
    // MARK: - Properties
    let networkUtil = HttpUtility.shared
    var payeeList: PayeeList?
    
    // MARK: - Initializer methods
    init(withList list: PayeeList?) {
        self.payeeList = list
    }

    var payeeListCount: Int {
        return payeeList?.data?.count ?? 0
    }
    
    func getPayeeRecord(index: Int) -> Payee? {
        guard let recrods = payeeList?.data, index < recrods.count else { return nil}
        return recrods[index]
    }
}
