//
//  TransactionViewModel.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit
import KRProgressHUD

class TransactionViewModel {
    
    // MARK: - Properties
    let dashbordResponse: DashBoardModel?
    let payeeList: PayeeList? = nil
    var singlePayee: Payee? = nil
    weak var delegate: ActionDelegate?
    let networkUtil = HttpUtility.shared
    
    // MARK: - Initializer methods
    init(model: DashBoardModel?, delegate: ActionDelegate?) {
        self.dashbordResponse = model
        self.delegate = delegate
        
    }
    
    //MARK: Payee list Network request
    func makePayeeListRequest(completionHandler: @escaping(_ retuslt: PayeeList?)-> Void) {
        let requestUrl = URL(string: Constants.baseURL + Constants.requetParams.payees)
        let request = HttpRequest(withUrl: requestUrl!, requestType: .GET)
        networkUtil.request(request: request, resultType: PayeeList.self) { response in
            switch response {
            case .success(let payeeList):
                completionHandler(payeeList)
            case .failure(let error):
                self.sendAlert(withTitle: Constants.Strings.payeelistheadermsg, message: error.reason ?? "" ,completionHandler: nil)
            }
        }
    }
    //MARK: Transfer POST reqiest
    func makeTransactionRequest(withModels models:  [BancoTextField], completionHandler: @escaping(_ retuslt: TransactionResponseModel?)-> Void) {
        let requestUrl = URL(string: Constants.baseURL + Constants.requetParams.transfer)
        let transactionModel = returnTransactionRequestModel(models: models)
        let requestbody = try! JSONEncoder().encode(transactionModel)
        let request = HttpRequest(withUrl: requestUrl!, requestType: .POST, requestBody: requestbody)
        networkUtil.request(request: request, resultType: TransactionResponseModel.self) { response in
           switch response {
            case .success(let transactionresponse):
                if let success = transactionresponse?.status, success == "success",
                   let id = transactionresponse?.data?.id, let amount = transactionresponse?.data?.amount {
                    let transactionId = Constants.Strings.transfercuccessmsg +  "\(amount)" + Constants.Strings.transfercuccessmsg1 + "\(id)"
                    self.sendAlert(withTitle: "Succesfull", message: transactionId) { (action) in
                        completionHandler(transactionresponse)
                    }
                } else {
                    self.sendAlert(withTitle: "Invalid Transaction", message: "Tranasction has some issue",completionHandler: nil)
                }
              case .failure(let error):
                self.sendAlert(withTitle: "Error", message: error.reason ?? "",completionHandler: nil)
            }
        }
    }
    
    private func returnTransactionRequestModel(models:  [BancoTextField]) -> TransactionRequest {
        let recipientAccountNo = singlePayee?.accountNo ?? ""
        let amount = models[3].textField.text ?? "0"
        let description = models[2].textField.text ?? ""
        let date = models[1].textField.text ?? ""
        return TransactionRequest(recipientAccountNo: recipientAccountNo, date: date, description: description, amount: Double(amount))
    }
    
    // MARK: - Transfer Submit validation
    func ValidateTransactionRequest(models: [BancoTextField]) -> Bool {
        guard validateRecepient(withComponent: models[0]) else { return false}
        guard validateCalendar(withComponent: models[1]) else { return false}
        guard validateDescription(withComponent: models[2]) else { return false}
        guard validateAmount(withComponent: models[3]) else { return false}
        return true
    }
    
    func validateRecepient(withComponent component: BancoTextField) -> Bool {
        guard let _ = component.validator, let text  = component.textField.text, text.count > 0 else {
            sendAlert(withTitle: component.validator?.componentName ?? "", message: Constants.Strings.errormessag1,completionHandler:nil)
            return false
        }
        return true
        
    }
    func validateCalendar(withComponent component: BancoTextField) -> Bool {
        guard let _ = component.validator, let text  = component.textField.text, text.count > 0 else {
            sendAlert(withTitle: component.validator?.componentName ?? "", message: Constants.Strings.dateerrormsg,completionHandler:  nil)
            return false
        }
        return true
        
    }
    func validateDescription(withComponent component: BancoTextField) -> Bool {
        guard let validator = component.validator, let text = component.textField.text, text.count > 0 else {
            sendAlert(withTitle: component.validator?.componentName ?? "", message: Constants.Strings.descerrormsg,completionHandler:  nil)
            return false}
        guard let validEntry = DataValidator.shared.returnValidationReport(withObject: validator, text: text) else { return true}
        sendAlert(withTitle: validator.componentName ?? "", message: validEntry,completionHandler:  nil)
        return false
    }
    
    func validateAmount(withComponent component: BancoTextField) -> Bool {
        guard let validator = component.validator, let text = component.textField.text, text.count > 0 else {
            sendAlert(withTitle: component.validator?.componentName ?? "", message: Constants.Strings.amounterrormsg,completionHandler:  nil)
            return false}
        guard let validEntry = DataValidator.shared.returnValidationReport(withObject: validator, text: text) else { return true}
        sendAlert(withTitle: validator.componentName ?? "", message: validEntry,completionHandler:  nil)
        return false
    }
    
    //MARK: - Alert Display
    private func sendAlert(withTitle title: String, message: String, completionHandler: ((UIAlertAction) -> Void)? ) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow,let topVC = window.topViewController() {
                topVC.notifyAlert(title , err: message,completionHandler: completionHandler)
            }
        }
        
    }
}
