//
//  BalanceCell.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class BalanceCell: UITableViewCell {
    //MARK: - Cell reuseidentifier
    static let reuseIdentifier = "BalanceCell"
   
    // MARK: - UI Components
    let rootView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(Colors.errormessage)
        return view
    }()
    var line: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.hexColor(Colors.line)
        return view
    }()
   private let label1 : UILabel = {
       let label = UILabel()
       label.text = "You have"
       label.numberOfLines = 1
       label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
       label.textColor = .white
       return label
   }()
   private var amount: UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.textColor = .white
       label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
       return label
   }()
  
    private let label2 : UILabel = {
        let label = UILabel()
        label.text = "in your account"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = .white
        return label
    }()
   
   // MARK: - Initializer methods
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       layoutViews()
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
    func configure(withAmount amount: String?) {
        self.selectionStyle = .none
        self.amount.text = amount
   }
   
   func layoutViews() {
    self.contentView.flex.define { (flex) in
        flex.addItem(rootView).width(100%).marginVertical(10).define { (flex) in
            flex.addItem(label1).marginLeft(20).marginTop(20)
            flex.addItem(amount).marginLeft(20).marginTop(10)
            flex.addItem(label2).marginLeft(20).marginTop(10).marginBottom(20)
           }
        flex.addItem(line).marginTop(10).height(2).width(100%).marginBottom(10)
       }
   }
   
   override func layoutSubviews() {
       super.layoutSubviews()
       layout()
   }
   func layout() {
    
       contentView.flex.layout(mode: .adjustHeight)
   }
   
   override func sizeThatFits(_ size: CGSize) -> CGSize {
       // 1) Set the contentView's width to the specified size parameter
       
       contentView.pin.width(size.height)
       
       // 2) Layout contentView flex container
       layout()
       
       // Return the flex container new size
       return contentView.frame.size
   }
    
}
