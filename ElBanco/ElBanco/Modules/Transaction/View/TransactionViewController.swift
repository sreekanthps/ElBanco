//
//  TransactionViewController.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit


class TransactionViewController: UIViewController {
    var transactionViewModel: TransactionViewModel?
    private var mainView: TransactionView {
        return self.view as! TransactionView
    }
    
    //MARK: Init methods
    init(withData dataModel: DashBoardModel?){
        super.init(nibName: nil, bundle: Bundle.main)
        transactionViewModel = TransactionViewModel(model: dataModel, delegate: self)
       }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: View controller lifecycle methods
    override func viewDidLoad() {
      self.view.backgroundColor = .white
      super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func loadView() {
        let view = TransactionView()
        view.delegate = self
        self.view = view
    }
    private func navigateToPayeeListScreen(withList list: PayeeList?) {
        DispatchQueue.main.async {
            let payeeListVC = PayeeListViewController(withList: list)
            payeeListVC.completionhandler = self.payeeListResponse
            self.navigationController?.pushViewController(payeeListVC, animated: false)
        }
        
    }
    private func payeeListResponse(_ payee: Payee?)  -> Void {
        self.transactionViewModel?.singlePayee = payee
        mainView.updateRecepient(withName: payee?.accountHolderName)
    }
    private func valdiateTranasctionRequest(withModel model: [BancoTextField]) {
        if let validationFlag = transactionViewModel?.ValidateTransactionRequest(models: model), validationFlag {
            transactionViewModel?.makeTransactionRequest(withModels: model, completionHandler: { (response) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: false)
                }
            })
        }
        
    }
}

extension TransactionViewController: ActionDelegate {
    func actionSender(didReceiveAction action: DelegateAction) {
        //Write action delegate code
        switch action {
        case TransactionView.Action.PayeeListDisplay:
            self.transactionViewModel?.makePayeeListRequest(completionHandler: { payeeList in
                self.navigateToPayeeListScreen(withList: payeeList)
            })
        case TransactionView.Action.CancelTransaction:
            self.navigationController?.popViewController(animated: false)
        case TransactionView.Action.SubmitTransaction(let validator) :
            self.valdiateTranasctionRequest(withModel: validator)
        default: break
        }
    }
    
    
}
