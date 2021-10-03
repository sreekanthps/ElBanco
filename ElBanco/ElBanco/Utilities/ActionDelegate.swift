//
//  ActionDelegate.swift
//  BitBucketList
//
//  Created by Sreekanth on 3/9/21.
//

import Foundation

public protocol DelegateAction {}
public protocol ActionDelegate: class {
    func actionSender(didReceiveAction action: DelegateAction)
}
