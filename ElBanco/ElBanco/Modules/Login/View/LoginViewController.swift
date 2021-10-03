//
//  LoginViewController.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
        // MARK: - View Mapping
        private var mainView: LoginView {
           return self.view as! LoginView
        }
        
        // MARK: - Properties
        var loginvmdodel: LoginViewModel?
       
       // MARK: - Init methods
       init(){
           super.init(nibName: nil, bundle: Bundle.main)
           loginvmdodel = LoginViewModel(delegate: self)
        }
 
       required init?(coder aDecoder: NSCoder) {
           return nil
       }
    
        // MARK: - Viewcontroller lifecycle methods
       override func viewDidLoad() {
         self.view.backgroundColor = .white
         super.viewDidLoad()
       }
    
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
      
       override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            mainView.clearInputFields()
       }
       
       override func loadView() {
           let view = LoginView()
           view.delegate = self
           self.view = view
       }
        
    private func navigatetoDashboard(withModel model: DashBoardModel?) {
        let dashboard = DashboardViewController(model: model)
        self.navigationController?.pushViewController(dashboard, animated: false)
    }
    private func validateLoginRequest(models: [BancoTextField]) {
        if let isValid =  self.loginvmdodel?.ValidateLoginRequest(models: models), isValid,
           let userId = models[0].textField.text,let passWord = models[1].textField.text {
            self.loginvmdodel?.makeLoginRequest(withUser: userId, password: passWord)
        }
    }
      
}

//MARK: ActionDelegate protocol
extension LoginViewController: ActionDelegate {
    func actionSender(didReceiveAction action: DelegateAction) {
        switch action {
        case LoginView.Action.LoginButtonPressed(let validation) :
            self.validateLoginRequest(models: validation)
        case LoginViewModel.Action.navigatetoDashboard(let dashboardModel) :
            navigatetoDashboard(withModel: dashboardModel)
        default: break
        }
    }
}

