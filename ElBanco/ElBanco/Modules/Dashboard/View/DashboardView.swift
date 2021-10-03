//
//  DashbaordView.swift
//  ElBanco
//
//  Created by Sreekanth on 30/9/21.
//

import Foundation
import UIKit

protocol TableViewDelegateProtocol {
    func numberofRows(section: Int) -> Int
    func onSelectRecord(index: Int)
    func dataforCell(index: IndexPath) -> Any?
}

class DashboardView: UIView {
   
    // MARK: - ActionDelegate
    enum Action: DelegateAction {
       case LogoutUser
       case TransferUser
    }
    
    // MARK: - Properties
    weak var actiondelegate: ActionDelegate?
    var tableView = UITableView()
    var delegate: TableViewDelegateProtocol?
    
    // MARK: - Initializer methods
    init() {
        super.init(frame: .zero)
        configure()
        layout()
    }
    
    convenience init(delegate: TableViewDelegateProtocol?) {
        self.init()
        self.delegate = delegate
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: -  Computed Properties
    private let rootView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = UIColor.hexColor(Colors.backGround)
        return uiview
    }()
    var logout: BancoButton = BancoButton(name: Constants.Strings.logoutmessage, type: .SMALL)
    var transfer: BancoButton = BancoButton(name: Constants.Strings.labelmessage, type: .CENTERLIGHT)
        
    
    // MARK: -  Configiration
    private func configure() {
          tableView.tableFooterView = UIView()
          tableView.backgroundColor = UIColor.hexColor(Colors.backGround)
          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorStyle = .none
          tableView.register(BalanceCell.self, forCellReuseIdentifier: BalanceCell.reuseIdentifier)
          tableView.register(ActivityHeaderTemplate.self, forHeaderFooterViewReuseIdentifier: ActivityHeaderTemplate.reuseIdentifier)
          tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
          tableView.estimatedSectionHeaderHeight = 80
          tableView.estimatedRowHeight = 80
          tableView.showsVerticalScrollIndicator = false
        logout.nextButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        transfer.nextButton.addTarget(self, action: #selector(transferUser), for: .touchUpInside)
    }
    
    // MARK: -  Button Click Event
    @objc func logoutUser(sender : UIButton){
        actiondelegate?.actionSender(didReceiveAction: Action.LogoutUser)
    }
    
    // MARK: -  Button Click Event
    @objc func transferUser(sender : UIButton){
        actiondelegate?.actionSender(didReceiveAction: Action.TransferUser)
    }
    
    
    // MARK: -  View alignment
    func layout() {
        removeAllSubviewsAndRemoveFromSuperview()
        rootView.flex.define { (flex) in
            flex.addItem().marginTop(40).direction(.row).justifyContent(.end).define{(flex) in
                flex.addItem(logout).width(90).height(25).marginRight(15)
            }
            flex.addItem(tableView).marginHorizontal(15).marginTop(20).grow(1)
            flex.addItem(transfer).height(40).marginHorizontal(30).marginTop(30).marginBottom(25)
        }
        addSubview(rootView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all()
        rootView.flex.layout()
    }
}

extension DashboardView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberofRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as? BalanceCell,
                  let accountBalance = delegate?.dataforCell(index: indexPath) as? AccountBalance else {return UITableViewCell() }
            let balance = accountBalance.balance ?? 0.0
            cell.configure(withAmount: "SGD " + String(balance))
            return cell
        } else {
            guard indexPath.section == 1 , let cell =  tableView.dequeueReusableCell(withIdentifier: TransactionCell.reuseIdentifier, for: indexPath) as? TransactionCell,
                  let record = delegate?.dataforCell(index: indexPath) as? Datas else { return UITableViewCell()}
            let dateString = record.date?.displayStringDate ?? ""
            cell.configure(withName: record.transterStatus, amount: "\(record.amount)", date: dateString)
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ActivityHeaderTemplate.reuseIdentifier) as? ActivityHeaderTemplate else { return UIView()}
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0}
        return Constants.sectionheaderheight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return Constants.accountrowheight}
        return Constants.tranasctionrowheight
    }
    
}
