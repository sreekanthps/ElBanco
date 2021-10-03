//
//  File.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
enum BancoButtonType  {
    case CENTER
    case SMALL
    case CENTERLIGHT
    case SMALLLIGHT
    var height: CGFloat {
        switch self {
        case .CENTER,.CENTERLIGHT: return 40
        case .SMALL,.SMALLLIGHT: return 25
        }
    }
    var textColor: UIColor? {
        switch self {
        case .CENTER,.SMALL: return .white
        case .SMALLLIGHT,.CENTERLIGHT: return UIColor.hexColor(Colors.errormessage)
        }
    }
    var backgroundColor: UIColor? {
        switch self {
        case .CENTER,.SMALL: return UIColor.hexColor(Colors.errormessage)
        case .SMALLLIGHT,.CENTERLIGHT: return .white
        }
    }
    var font: UIFont {
        switch self {
        case .CENTER,.CENTERLIGHT: return UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        case .SMALL,.SMALLLIGHT: return UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        }
    }
    
    
}
class BancoButton: UIView {
    
    // MARK: - UI Components
    let root: UIView = UIView()
    
    var  nextButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
  
    
    // MARK: - Initializer methods
    init(name: String?, type: BancoButtonType) {
       super.init(frame: .zero)
        configure(buttonName: name, type: type)
        loadView(type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: -  Methods
    func configure(buttonName: String?, type: BancoButtonType) {
        nextButton.layer.cornerRadius = type.height/2
        nextButton.setTitle(buttonName, for: .normal)
        nextButton.setTitleColor(type.textColor, for: .normal)
        nextButton.backgroundColor = type.backgroundColor
        nextButton.titleLabel?.font = type.font
    }
    
   
    func loadView(type: BancoButtonType) {
        removeAllSubviewsAndRemoveFromSuperview()
        root.flex.define { (flex) in
            flex.addItem(nextButton).height(type.height).width(100%).alignSelf(.center)
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
