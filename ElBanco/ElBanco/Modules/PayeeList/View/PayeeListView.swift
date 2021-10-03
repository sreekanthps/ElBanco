//
//  PayeeListView.swift
//  ElBanco
//
//  Created by Sreekanth on 2/10/21.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout


class PayeeListView: UIView {
    // MARK: - ActionDelegate
    enum Action: DelegateAction {
       case Cancel
    }
    // MARK: - Initializer methods
    init() {
        super.init(frame: .zero)
        configure()
        layout()
    }
    // MARK: - Properties
    weak var actiondelegate: ActionDelegate?
    var tableView = UITableView()
    var delegate: TableViewDelegateProtocol?
    
    convenience init(delegate: TableViewDelegateProtocol?) {
        self.init()
        self.delegate = delegate
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: -  Properties
    private let rootView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = UIColor.hexColor(Colors.backGround)
        return uiview
    }()
    
    var line: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.hexColor(Colors.errormessage)
        return view
    }()
    var cancel: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        return button
    }()
    var payeeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = "Select Payee"
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        return label
    }()
   
    // MARK: -  Configiration
    private func configure() {
          tableView.tableFooterView = UIView()
          tableView.backgroundColor = UIColor.hexColor(Colors.backGround)
          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorStyle = .none
          tableView.register(PayeeListCell.self, forCellReuseIdentifier: PayeeListCell.reuseIdentifier)
          tableView.estimatedRowHeight = 60
          tableView.showsVerticalScrollIndicator = false
        cancel.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
    }
    
    // MARK: -  Button Click Event
    @objc func cancelButton(sender : UIButton){
        actiondelegate?.actionSender(didReceiveAction: Action.Cancel)
    }
    
    
    // MARK: -  View alignment
    func layout() {
        removeAllSubviewsAndRemoveFromSuperview()
        rootView.flex.define { (flex) in
            flex.addItem().direction(.row).marginTop(25).height(60).alignItems(.center).define { (flex) in
                flex.addItem(payeeLabel).grow(1)
                flex.addItem(cancel).size(40).marginRight(15)
            }
            flex.addItem(line).width(100%).height(2)
            flex.addItem(tableView).marginHorizontal(15).marginBottom(30).height(Constants.payeetableHeight)
        }
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all()
        rootView.flex.layout()
    }
}

extension PayeeListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberofRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PayeeListCell.reuseIdentifier, for: indexPath) as? PayeeListCell,
              let payee = delegate?.dataforCell(index: indexPath) as? Payee else {return UITableViewCell() }
        cell.configure(withName: payee.accountHolderName, number: payee.accountNo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelectRecord(index: indexPath.row)
    }
}
