//
//  File.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

class TransactionCell: UITableViewCell {
    
    //MARK: - Cell reuseidentifier
    static let reuseIdentifier = "TransactionCell"
   
    // MARK: - UI Components
    let rootView = UIView()
   private let dateLabel : UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
       label.textColor = .black
       return label
   }()
   private var transfer: UILabel = {
       let label = UILabel()
       label.numberOfLines = 1
       label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
       return label
   }()
  
    private let amount : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        label.textColor = .black
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
   
   
   func configure(withName name: String?, amount: String?, date: String?) {
        self.dateLabel.text = date
        self.amount.text = amount
        self.transfer.text = name
   }
   
   func layoutViews() {
    self.selectionStyle = .none
       self.contentView.flex.define { (flex) in
        flex.addItem(rootView).marginVertical(10).direction(.row).justifyContent(.spaceBetween).define { (flex) in
            flex.addItem(dateLabel)
            flex.addItem(transfer).marginLeft(10)
            flex.addItem(amount)
           }
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
