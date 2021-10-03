//
//  ActivityHeaderTemplate.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit


class ActivityHeaderTemplate: UITableViewHeaderFooterView {
    //MARK: - Cell reuseidentifier
    static let reuseIdentifier = "ActivityHeaderTemplate"
    
    // MARK: - Properties
    static let height: CGFloat = 100
    
    // MARK: - UI Components
    fileprivate let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Your Activity"
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        titleLabel.sizeToFit()
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the label vertically. Note that we don't need to specify the size, it has already be adjusted in init().
        titleLabel.pin.horizontally().vCenter()
    }
}
