//
//  SplashViewController.swift
//  BitBucketList
//
//  Created by Sreekanth on 3/9/21.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
        // MARK: - View Mapping
        private var mainView: SplashView {
            return self.view as! SplashView
        }
        
        // MARK: - Init methods
        init(){
            super.init(nibName: nil, bundle: Bundle.main)
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
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            startAnimation()
        }
        
        override func loadView() {
            let view = SplashView()
            view.delegate = self
            self.view = view
        }
        
        func startAnimation() {
            mainView.startLoadAnimation()
        }
        
        func navigateToDashBoard() {
            let login = LoginViewController()
            self.navigationController?.pushViewController(login, animated: false)
        }
}

//MARK: ActionDelegate protocol
extension SplashViewController: ActionDelegate {
    func actionSender(didReceiveAction action: DelegateAction) {
        switch action {
        case SplashView.Action.AnimationComplete :
            self.navigateToDashBoard()
         default: break
        }
    }
}
