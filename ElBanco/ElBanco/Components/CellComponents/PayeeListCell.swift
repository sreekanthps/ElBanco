//
//  PayeeListCell.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit

class PayeeListCell: UITableViewCell {
    //MARK: - Cell reuseidentifier
    static let reuseIdentifier = "PayeeListCell"
   
    // MARK: - UI Components
   let rootView = UIView()
   private let name : UILabel = {
       let label = UILabel(frame: .zero)
       label.numberOfLines = 1
       label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
       label.textColor = .black
       return label
   }()
   private var account: UILabel = {
    let label = UILabel(frame: .zero)
       label.numberOfLines = 1
       label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
       return label
   }()
    var line: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.hexColor(Colors.errormessage)
        return view
    }()
  
    // MARK: - Initializer methods
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       layoutViews()
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
    func configure(withName name: String?, number: String? ) {
        self.selectionStyle = .none
        self.name.text = name
        self.account.text = number
   }
   
   func layoutViews() {
       self.contentView.flex.define { (flex) in
        flex.addItem(rootView).marginVertical(10).define { (flex) in
            flex.addItem(name).marginTop(5).marginLeft(10)
            flex.addItem(account).marginTop(8).marginBottom(10).marginLeft(10)
            flex.addItem(line).height(1)           }
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
