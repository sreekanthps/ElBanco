//
//  DashboardViewController.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    // MARK: - View Mapping
    private var mainView: DashboardView {
        return self.view as! DashboardView
    }
    
    // MARK: -  Properties
    var dashboardViewmodel: DashboardViewModel?
    
    // MARK: -  Initializers
    init(model: DashBoardModel?){
        super.init(nibName: nil, bundle: Bundle.main)
        dashboardViewmodel = DashboardViewModel(model: model,delegate: self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: -  ViewController lifecycle methods
    override func viewDidLoad() {
      super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        let view = DashboardView(delegate: self)
        view.actiondelegate = self
        self.view = view
    }
    private func navigateToTransactionScreen(){
        let viewController = TransactionViewController(withData: dashboardViewmodel?.dashbordResponse)
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
}

extension DashboardViewController: ActionDelegate {
    func actionSender(didReceiveAction action: DelegateAction) {
        switch action {
        case DashboardView.Action.LogoutUser:
            HttpUtility.shared.authToken = nil
            self.navigationController?.popViewController(animated: false)
        case DashboardView.Action.TransferUser:
            navigateToTransactionScreen()
        default: break
        }
    }
    
}

extension DashboardViewController: TableViewDelegateProtocol {
    func onSelectRecord(index: Int) {
     // In future to implement on Select
    }
    
    func dataforCell(index: IndexPath) -> Any? {
        if index.section == 0 { return dashboardViewmodel?.returnAccountBalance()}
            return dashboardViewmodel?.returnTransactionRecord(index: index.row)
     }
    
    func numberofRows(section: Int) -> Int {
        if section == 0 { return 1}
        return dashboardViewmodel?.returnTransactionRows() ?? 0
    }
    
   
    
}
