//
//  BancoTextField.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

enum TextFieldType {
    case UserId
    case Password
    case Calendar
    case Amount
    case Description
    case Selection
    
    var isEditable: Bool {
        if self == .Selection { return false}
        return true
    }
}

class BancoTextField: UIView {
    
    // MARK: -  Properties
    
    var type: TextFieldType
    var validator: DataModel?
    
    // MARK: - UI Components
    let root: UIView = UIView()
    var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        textField.textAlignment = .left
        return textField
    }()
    var icon: UIImageView = {
        let image = UIImageView(frame: .zero)
        return image
    }()
    
    var line: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.hexColor(Colors.line)
        return view
    }()
    let errorMessage : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexColor(Colors.errormessage)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initializer methods
    init(type: TextFieldType,validator: String) {
       self.type = type
       self.validator =  DataValidator.shared.returnValidator(withName: validator)
       super.init(frame: .zero)
       configure()
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: -  Configuration Methods
    func configure() {
        if let required = validator?.rightIconRequired,
           let image = validator?.rightIcon, required { icon.image = UIImage(named: image) }
        if type == .Password { textField.isSecureTextEntry = true}
        if type == .Amount { textField.keyboardType = .numberPad}
        textField.placeholder = validator?.placeHolder ?? ""
        textField.isUserInteractionEnabled = type.isEditable
        textField.delegate = self
    }
    
   
    func loadView() {
        removeAllSubviewsAndRemoveFromSuperview()
        root.flex.define { (flex) in
            flex.addItem().direction(.row).define { (flex) in
                flex.addItem(textField).height(40).grow(1)
                if let required = validator?.rightIconRequired, required {
                    flex.addItem(icon).size(30)
                }
            }
            flex.addItem(line).marginTop(2).height(1)
            flex.addItem(errorMessage)
               
        }
        addSubview(root)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        root.pin.all()
        
        // Then let the flexbox container layout itself
        root.flex.layout()
    }
}

extension BancoTextField: UITextFieldDelegate {
    
    func textField(_: UITextField, shouldChangeCharactersIn: NSRange, replacementString: String) -> Bool {
        guard let maxLength = validator?.maxLength, textField.text!.count < maxLength else { return false }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
