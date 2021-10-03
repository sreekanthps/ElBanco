//
//  PayeeListViewController.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit

class PayeeListViewController: UIViewController {
    // MARK: - View Mapping
    private var mainView: PayeeListView {
        return self.view as! PayeeListView
    }
    
    var completionhandler: ((_ payee: Payee?)  -> Void)?
    // MARK: - Stored Properties
    var payeelIstViewModel: PayeeListViewModel?
    
    // MARK: -  Initializers
    init(withList list: PayeeList?){
        super.init(nibName: nil, bundle: Bundle.main)
        payeelIstViewModel = PayeeListViewModel(withList: list)
        
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
        let view = PayeeListView(delegate: self)
        view.actiondelegate = self
        self.view = view
    }
    
}

extension PayeeListViewController: TableViewDelegateProtocol {
    func numberofRows(section: Int) -> Int {
        return  payeelIstViewModel?.payeeListCount ?? 0
    }
    
    func onSelectRecord(index: Int) {
        let record = payeelIstViewModel?.getPayeeRecord(index: index)
        self.completionhandler?(record)
        self.navigationController?.popViewController(animated: false)
    }
    
    func dataforCell(index: IndexPath) -> Any? {
        return payeelIstViewModel?.getPayeeRecord(index: index.row)
    }
}

extension PayeeListViewController: ActionDelegate {
    func actionSender(didReceiveAction action: DelegateAction) {
        switch action {
        case PayeeListView.Action.Cancel:
            self.navigationController?.popViewController(animated: false)
        default: break
        }
    }
    
    
}
