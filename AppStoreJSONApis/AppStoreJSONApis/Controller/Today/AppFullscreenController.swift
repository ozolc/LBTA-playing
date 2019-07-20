//
//  AppFullscreenController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 20/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {
    
    var dismissHandler: (() -> ())?
//    var todayItem: TodayItem?
    var todayItem: TodayItem
    
    // dependency injection constructor
    init(todayItem: TodayItem) {
        self.todayItem = todayItem
        super.init(nibName: nil, bundle: nil)  // designated initializer of the superclass 'UIViewController'"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = AppFullscreenHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = todayItem
            return headerCell
        }
        
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    @objc func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
