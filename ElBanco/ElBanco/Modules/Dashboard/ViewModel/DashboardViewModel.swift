//
//  DashboardModelView.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
class DashboardViewModel {
    // MARK: - Properties
    let dashbordResponse: DashBoardModel?
    weak var delegate: ActionDelegate?
    
    // MARK: - init methods
    init(model: DashBoardModel?, delegate: ActionDelegate?) {
        self.dashbordResponse = model
        self.delegate = delegate
    }
    
    func returnTransactionRows() -> Int {
        return dashbordResponse?.transaction?.data.count ?? 0
    }
    
    func returnTransactionRecord(index: Int) -> Datas? {
         guard let data = dashbordResponse?.transaction?.data, index < data.count  else {return nil}
        return data[index]
    }
    
    func returnAccountBalance() -> AccountBalance? {
        return dashbordResponse?.balance
    }
}
