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
    private var refreshControl: UIRefreshControl?
    var userListViewModel: UserListViewModel?
    var delegate: UserListCompatible?
    
    
    init(tableview: UITableView, refreshControl: UIRefreshControl, userListViewModel: UserListViewModel) {
        super.init()
        self.tableview = tableview
        self.refreshControl = refreshControl
        self.tableview?.refreshControl = refreshControl
        self.refreshControl?.addTarget(self, action: #selector(didRefreshData(refresh:)), for: .valueChanged)
        self.userListViewModel = userListViewModel
        self.tableview?.dataSource = self
        self.tableview?.delegate = self
        self.userListViewModel?.delegate = self
        self.userListViewModel?.getUserData()
    }
    
    
    @objc func didRefreshData(refresh: UIRefreshControl) {
        self.userListViewModel?.getUserData()
    }
}

extension UserListPresenter: UserListDataProvider {
    func didUpdateUserData() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.tableview?.reloadData()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
//            self.tableview?.reloadData()
//        }
    }
}

extension UserListPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel!.isLoading ? 15 : userListViewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let loading = userListViewModel?.isLoading, loading {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonUserCell.defaultIdentifier, for: indexPath) as! SkeletonUserCell
            return cell
        }
        let data = userListViewModel?.getModelForIndex(indexPath.row)
        return data?.cellForTableView(tableView: tableView, atIndexPath: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!userListViewModel!.isLoading && !userListViewModel!.isSearchModeOn) && (indexPath.row == userListViewModel!.users.count - 1) {
            tableView.addLoading(indexPath) {
                self.userListViewModel?.loadMoreUsers()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didRecieveNavigationRequest(withIndex: indexPath.row)
    }
}
