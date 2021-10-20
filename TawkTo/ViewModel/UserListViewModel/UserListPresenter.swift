//
//  UserListPresenter.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 13/10/21.
//

import Foundation
import UIKit
import SnackBar_swift

protocol UserListCompatible {
    func didRecieveNavigationRequest(withIndex index: Int)
    func didCheckCountForUserData()
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
        self.refreshControl?.addTarget(self, action: #selector(didRefreshData(refresh:)), for: .valueChanged)
        
        self.tableview?.dataSource = self
        self.tableview?.delegate = self
        
        self.userListViewModel = userListViewModel
        self.userListViewModel?.delegate = self
        
        NetworkListner.shared.delegate = self
        
        self.userListViewModel?.initiateDataToDisplay()
    }
    
    @objc func didRefreshData(refresh: UIRefreshControl) {
        if NetworkListner.shared.isNetworkAvailable {
            self.userListViewModel?.getUserData()
        }
    }
}

//MARK: - Extension for UserListDataProvider
extension UserListPresenter: UserListDataProvider {
    
    func didGetErrorInFetchingUserList(error: HTTPNetworkError) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let topController = keyWindow?.rootViewController, error.reason != nil {
            topController.showAppAlertWithOK(message: error.reason!, buttonAction: nil, style: .alert, completion: nil)
        }
    }
    
    func didUpdateUserData() {
        DispatchQueue.main.async {
            self.delegate?.didCheckCountForUserData()
            self.refreshControl?.endRefreshing()
            self.tableview?.reloadData()
        }
    }
}

//MARK: - Extension for UITableViewDataSource and UITableViewDelegate
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
        if NetworkListner.shared.isNetworkAvailable {
            if (!userListViewModel!.isLoading && !userListViewModel!.isSearchModeOn) && (indexPath.row == userListViewModel!.users.count - 1) {
                tableView.addLoading(indexPath) {
                    self.userListViewModel?.loadMoreUsers()
                }
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

//MARK: - Extension for NetworkUpdates
extension UserListPresenter: NetworkUpdates {
    func networkDidBecameActive() {
        self.tableview?.refreshControl = refreshControl
        self.userListViewModel?.getUserData()
    }
    
    func networkDidBecameDeactive() {
        SnackBar.make(in: self.tableview!, message: "The Internet connection appears to be offline.", duration: .lengthLong).show()
        self.tableview?.refreshControl = nil
        self.userListViewModel?.getAllUserFromDB()
    }
    
    
}
