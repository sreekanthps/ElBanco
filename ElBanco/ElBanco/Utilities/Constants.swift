//
//  Constants.swift
//  BitBucketList
//
//  Created by Sreekanth on 3/9/21.
//

import Foundation
import UIKit

enum Constants {
    enum General{
        static let delayTimer = 0.1
    }
  static let baseURL = "http://localhost:8080/"
    struct requetParams {
        static let login = "authenticate/login"
        static let balance = "account/balances"
        static let transactions = "account/transactions"
        static let payees = "account/payees"
        static let transfer = "transfer"
    }
  static let timeInterval: TimeInterval = 30
  static let splashImage = "bitbucketrepolist"
  enum Animation {
        static let animationrepeat: Float = 1
        static let animationFile = "elbanco"
        
    }
    struct Decimals {
        static let half: Double = 0.5
    }
  static let screenSize: CGRect = UIScreen.main.bounds
  static let screenWidth = screenSize.width
  static let screenHeight = screenSize.height
  static let tableHeight = screenHeight - 200
  static let payeetableHeight = screenHeight - 100
  static let dateformmatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  static let stringformatter = "MMM d, yyyy"
  static let shortstringformatter = "MMM d"
    
    struct Strings {
        static let errormessag1 = "Please select Recipient"
        static let labelmessage = "Make a transfer"
        static let logoutmessage = "Log out"
        static let invalidloginmessage = "Login credentials are invalid"
        static let invalidloginheadermsg = "Invalid Login"
        static let payeelistheadermsg = "PayeeList Error"
        static let payeelistmsg = "Can not retrieve payee list"
        static let dateerrormsg = "Please select Date"
        static let descerrormsg = "Please Enter Description"
        static let amounterrormsg = "Please Enter Amount"
        static let transfercuccessmsg = "Your transaction for amount "
        static let transfercuccessmsg1 = " is successfull with ID: "
    }
    static let accountrowheight: CGFloat = 200
    static let tranasctionrowheight: CGFloat = 80
    static let sectionheaderheight: CGFloat = 80
}
