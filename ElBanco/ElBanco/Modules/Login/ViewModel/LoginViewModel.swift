//
//  LoginViewModel.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit
import KRProgressHUD

class LoginViewModel {
    
    // MARK: - ActionDelegate
    enum Action: DelegateAction {
        case navigatetoDashboard(model: DashBoardModel?)
    }
    // MARK: - Stored Properties
    weak var delegate: ActionDelegate?
    var group: DispatchGroup? = nil
    let amount = DispatchQueue(label: "amountRequest")
    let transaction = DispatchQueue(label: "transaction")
    var txnResponse: TransactionResponse? = nil
    var accountBalance: AccountBalance? = nil
    let networkUtil = HttpUtility.shared
    
    // MARK: - Init methods
    init(delegate: ActionDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Login Request
    func makeLoginRequest(withUser userId: String, password: String) {
        let requestUrl = URL(string: Constants.baseURL + Constants.requetParams.login)
        let loginmodel = LoginRequest(username: userId.lowercased(), password: password)
        let requestbody = try! JSONEncoder().encode(loginmodel)
        let request = HttpRequest(withUrl: requestUrl!, requestType: .POST, requestBody: requestbody)
        KRProgressHUD.show()
        networkUtil.request(request: request, resultType: LoginResponse.self) { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               KRProgressHUD.dismiss()
            }
            switch response {
            case .success(let loginresponse):
                if let success = loginresponse?.status, success == "success" {
                    HttpUtility.shared.authToken = loginresponse?.token
                    self.makeConcurrentRequest() 
                } else {
                    self.sendAlert(withTitle: Constants.Strings.invalidloginheadermsg, message: Constants.Strings.invalidloginmessage,completionHandler: nil)
                }
               case .failure(let error):
                self.sendAlert(withTitle: "Error", message: error.reason ?? "",completionHandler: nil)
            }
        }
    }
    
    func makeAmountRequest<T:Decodable>(witthParam param: String,completionHandler:@escaping(_ retuslt: T?)-> Void) {
        let requestUrl = URL(string: Constants.baseURL + param)
        let request = HttpRequest(withUrl: requestUrl!, requestType: .GET)
        networkUtil.request(request: request, resultType: T.self) { response in
            switch response {
            case .success(let accountBalance):
                completionHandler(accountBalance)
            case .failure( _):
                completionHandler(nil)
            }
        }
    }
    
    func makeConcurrentRequest() {
        group = DispatchGroup()
        group?.enter()
        amount.async(group: group) {
            self.makeAmountRequest(witthParam: Constants.requetParams.balance) { (result: AccountBalance?) in
                self.accountBalance = result
                self.group?.leave()
            }
        }
        group?.enter()
        transaction.async(group: group) {
            self.makeAmountRequest(witthParam: Constants.requetParams.transactions)  { (result: TransactionResponse?) in
                self.txnResponse = result
                self.group?.leave()
            }
        }
        group?.notify(queue: .main) {
            let dashBoard = DashBoardModel(transaction: self.txnResponse, balance: self.accountBalance)
            self.delegate?.actionSender(didReceiveAction: Action.navigatetoDashboard(model: dashBoard))
        }
    }
    
    // MARK: - Valiate Login Values
    func ValidateLoginRequest(models: [BancoTextField]) -> Bool {
        if ValidateModelRequest(withComponent: models[0]),  ValidateModelRequest(withComponent: models[1]) {
            return true
        }
        return false
    }
    
    // MARK: - Valiate Input Values
    private func ValidateModelRequest(withComponent component: BancoTextField) -> Bool {
        guard let validator = component.validator, let text = component.textField.text else {
            sendAlert(withTitle: component.validator?.componentName ?? "", message: component.validator?.errorMessage ?? "",completionHandler: nil)
            return false
        }
        guard let validEntry = DataValidator.shared.returnValidationReport(withObject: validator, text: text) else { return true}
        sendAlert(withTitle: validator.componentName ?? "", message: validEntry,completionHandler: nil)
       return false
    }
    
    private func sendAlert(withTitle title: String, message: String,completionHandler: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow,let topVC = window.topViewController() {
                topVC.notifyAlert(title , err: message,completionHandler: completionHandler)
            }
        }
    }
}
