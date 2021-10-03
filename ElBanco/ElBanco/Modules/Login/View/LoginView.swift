//
//  LoginView.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: - ActionDelegate
    enum Action: DelegateAction {
        case LoginButtonPressed(validation: [BancoTextField])
    }
    
    // MARK: -  Properties
    let root: UIView = UIView()
    weak var delegate: ActionDelegate?
    
    //MARK: - UI Elements
    var userName: BancoTextField = BancoTextField(type: .UserId, validator: "UserId")
    var passWord: BancoTextField = BancoTextField(type: .Password, validator: "Password")
    var login: BancoButton = BancoButton(name: "LOGIN", type: .CENTER)
        
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
        login.nextButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    // MARK: -  Button Click Event
    @objc func buttonClicked(sender : UIButton){
        delegate?.actionSender(didReceiveAction: Action.LoginButtonPressed(validation: [userName,passWord]))
    }
    
   
    func loadView() {
        removeAllSubviewsAndRemoveFromSuperview()
        root.flex.justifyContent(.center).define { (flex) in
            flex.addItem(userName).height(40).marginHorizontal(40)
            flex.addItem(passWord).marginTop(20).marginHorizontal(40)
            flex.addItem(login).marginTop(40).marginHorizontal(30)
        }
        addSubview(root)
    }
    
    //MARK: - Clear Text Field
    func clearInputFields() {
        self.userName.textField.text = ""
        self.passWord.textField.text = ""
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
