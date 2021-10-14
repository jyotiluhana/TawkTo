//
//  UserListPresenter.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 13/10/21.
//

import Foundation
import UIKit

protocol UserListCompatible {
    func didRecieveNavigationRequest(withIndex index: Int)
}

class UserListPresenter: NSObject {
    
    private var tableview: UITableView?
    var userListViewModel: UserListViewModel?
    var delegate: UserListCompatible?
    
    
    init(tableview: UITableView, userListViewModel: UserListViewModel) {
        super.init()
        self.tableview = tableview
        self.userListViewModel = userListViewModel
        self.tableview?.dataSource = self
        self.tableview?.delegate = self
        self.userListViewModel?.delegate = self
        self.userListViewModel?.getUserData(0)
    }
}

extension UserListPresenter: UserListDataProvider {
    func didUpdateUserData() {
        DispatchQueue.main.async {
            self.tableview?.reloadData()
        }
    }
}

extension UserListPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = userListViewModel?.getModelForIndex(indexPath.row)
        return data?.cellForTableView(tableView: tableView, atIndexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didRecieveNavigationRequest(withIndex: indexPath.row)
    }
}
