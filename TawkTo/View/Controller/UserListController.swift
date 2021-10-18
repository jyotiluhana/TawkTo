//
//  ViewController.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import UIKit

class UserListController: UIViewController{

    //MARK: Properties
    var userListPresenter: UserListPresenter?
    var userListViewModel = UserListViewModel()
    static let networkListener = NetworkListner()
    
    //MARK: Controls
    lazy var tableView : UITableView = {
        let tableview = UITableView()
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
    
    //MARK: View load methods
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
    }
    
    //MARK: View setup
    private func setupView() {
        self.view.addSubview(tableView)
    }

    private func addConstraints() {
        self.tableView.fillToSuperview()
    }
}

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

extension UserListController: UserListCompatible {
    func didRecieveNavigationRequest(withIndex index: Int) {
        let data = userListViewModel.getModelForIndex(index)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userDetailsVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailsController") as! UserDetailsController
        userDetailsVC.userCellViewModel = data
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
