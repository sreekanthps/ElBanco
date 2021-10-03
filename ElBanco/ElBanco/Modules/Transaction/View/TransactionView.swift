//
//  TransactionView.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit

class TransactionView: UIView {
    // MARK: - ActionDelegate
    enum Action: DelegateAction {
       case SubmitTransaction(validation: [BancoTextField])
       case CancelTransaction
       case PayeeListDisplay
    }
    
    // MARK: -  Properties
    let root: UIView = UIView()
    weak var delegate: ActionDelegate?
   
    // MARK: - UI Components
    var recipient = BancoTextField(type: .Selection, validator: "Selection")
    var dateofTransfer = BancoTextField(type: .Calendar, validator: "Calendar")
    var txndescription  = BancoTextField(type: .Description, validator: "Description")
    var amount  = BancoTextField(type: .Amount, validator: "Amount")
    var cancel = BancoButton(name: "CANCEL", type: .CENTERLIGHT)
    var submit = BancoButton(name: "SUBMIT", type: .CENTERLIGHT)
   
    
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = "Make a transfer"
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        return label
    }()
    // MARK: -  Init
    init() {
       super.init(frame: .zero)
       configure()
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    // MARK: -  Methods
    func configure() {
        submit.nextButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        cancel.nextButton.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        recipient.root.addGestureRecognizer(tap)
        dateofTransfer.textField.datePicker(target: self,
                                            doneAction: #selector(doneAction),
                                            cancelAction: #selector(cancelAction),
                                            datePickerMode: .date)
        txndescription.textField.datePicker(target: self,
                                            doneAction: #selector(descriptionAction),
                                            cancelAction: #selector(cancelAction),
                                            datePickerMode: .date,calenderMode: false)
        amount.textField.datePicker(target: self,
                                    doneAction: #selector(amountdoneAction),
                                    cancelAction: #selector(cancelAction),
                                    datePickerMode: .date,calenderMode: false)
       
    }
    
    
    @objc
        func cancelAction() {
            dateofTransfer.textField.resignFirstResponder()
            txndescription.textField.resignFirstResponder()
            amount.textField.resignFirstResponder()
        }

        @objc
        func doneAction() {
            if let datePickerView = self.dateofTransfer.textField.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: datePickerView.date)
                dateofTransfer.textField.text = dateString
                self.dateofTransfer.textField.resignFirstResponder()
            }
        }
    @objc
    func descriptionAction() {
        txndescription.textField.resignFirstResponder()
    }
    @objc
    func amountdoneAction() {
        amount.textField.resignFirstResponder()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.actionSender(didReceiveAction: Action.PayeeListDisplay)
      }
    
    // MARK: -  Button Click Event
    @objc func buttonClicked(sender : UIButton){
        delegate?.actionSender(didReceiveAction: Action.SubmitTransaction(validation: [recipient,dateofTransfer,txndescription,amount]))
    }
    
    // MARK: -  Button Click Event
    @objc func cancelClicked(sender : UIButton){
        delegate?.actionSender(didReceiveAction: Action.CancelTransaction)
    }
    
    func updateRecepient(withName name: String?){
        recipient.textField.text = name
    }
    
    func loadView() {
        removeAllSubviewsAndRemoveFromSuperview()
        root.flex.define { (flex) in
            flex.addItem().marginTop(40).define { (flex) in
                flex.addItem(headerLabel).marginVertical(10).marginLeft(30)
            }
            flex.addItem().justifyContent(.center).grow(1).define { (flex) in
                flex.addItem(recipient).marginHorizontal(30)
                flex.addItem(dateofTransfer).marginTop(20).marginHorizontal(30)
                flex.addItem(txndescription).marginTop(20).marginHorizontal(30)
                flex.addItem(amount).marginTop(20).marginHorizontal(30)
            }
            flex.addItem().direction(.row).justifyContent(.center).marginBottom(30).define { (flex) in
                flex.addItem(cancel).width(120).marginRight(5)
                flex.addItem(submit).width(120).marginLeft(5)
            }
        }
        addSubview(root)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        root.pin.all()
        root.flex.layout()
    }
    
}
