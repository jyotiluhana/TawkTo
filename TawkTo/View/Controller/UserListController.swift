//
//  ViewController.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import UIKit

class UserListController: UIViewController{

    //MARK: - Properties
    var userListPresenter: UserListPresenter?
    var userListViewModel = UserListViewModel()
    
    //MARK: - Controls
    lazy var tableView : UITableView = {
        let tableview = UITableView()
        tableview.accessibilityIdentifier = "UsersTableView"
        return tableview
    }()
    
    lazy var searchController : UISearchController = {
        let searchControl = UISearchController()
        searchControl.searchResultsUpdater = self
        return searchControl
    }()
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    //MARK: - View load methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.addConstraints()
        
        self.title = "Users"
        
        let viewCells: [Reusable.Type] = [UserListCell.self, UserListInvertedCell.self, UserListNoteCell.self, UserListNoteInvertedCell.self, SkeletonUserCell.self]
        for viewCell in viewCells {
            self.tableView.enroll(viewCell)
        }
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !userListViewModel.isSearchModeOn {
            self.userListPresenter = UserListPresenter(tableview: tableView, refreshControl: refreshControl, userListViewModel: userListViewModel)
            self.userListPresenter?.delegate = self
        }
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkListner.reachabilityChanged(note:)), name: .online, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: View setup
    private func setupView() {
        self.view.addSubview(tableView)
    }

    private func addConstraints() {
        self.tableView.fillToSuperview()
    }
}

//MARK: - Extension for UISearchResultsUpdating
extension UserListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.userListViewModel.isSearchModeOn = true
            self.userListViewModel.fetchFilteredUser(withText: text)
        } else {
            self.userListViewModel.isSearchModeOn = false
            self.userListViewModel.getUserData()
        }
    }
}

//MARK: - Extension for UserListCompatible
extension UserListController: UserListCompatible {
    func didCheckCountForUserData() {
        if self.userListViewModel.getCount() == 0 {
            self.tableView.showNoDataIndicator()
        } else {
            self.tableView.removeNoDataIndicator()
        }
    }
    
    func didRecieveNavigationRequest(withIndex index: Int) {
        let data = userListViewModel.getModelForIndex(index)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userDetailsVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailsController") as! UserDetailsController
        userDetailsVC.userCellViewModel = data
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
