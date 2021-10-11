//
//  ViewController.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import UIKit

class UserListController: UIViewController {

    //MARK: Properties
    var userCellViewModel = [UserCellViewModel]()
    
    //MARK: Controls
    lazy var tableView : UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    
    lazy var serachController : UISearchController = {
        let searchControl = UISearchController()
        searchControl.searchResultsUpdater = self
        return searchControl
    } ()
    
    //MARK: View load methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.addConstraints()
        
        let viewCells: [Reusable.Type] = [UserListCell.self, UserListInvertedCell.self, UserListNoteCell.self, UserListNoteInvertedCell.self]
        for viewCell in viewCells {
            self.tableView.enroll(viewCell)
        }
        
        navigationItem.searchController = serachController
        
        fetchUserData()
    }
    
    //MARK: View setup
    private func setupView() {
        self.view.addSubview(tableView)
    }

    private func addConstraints() {
        self.tableView.fillToSuperview()
    }
}

extension UserListController {
    func fetchUserData () {
        var params = [String : Any]()
        params["since"] = 0
        let requestUrl = URL(string: "https://api.github.com/users?\(params.queryString)")
        let request = HTTPRequest(withUrl: requestUrl!, forHttpMethod: .get, requestBody: nil)
        APIServices.sharedInstance.request(httpRequest: request, resultType: [Users].self) { (response) in
            switch response {
            case.success(let userResponse):
                if let userResponse = userResponse {
                    for user in userResponse {
                        self.userCellViewModel.append(UserCellViewModel(user))
                    }
                }
                break
            case .failure(let error):
                print("Error: \(error)")
                break
            }
        }
    }
}

extension UserListController: UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCellViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = userCellViewModel[indexPath.row]
        return data.cellForTableView(tableView: tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension UserListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // code here
//        filterContentForSearchText(searchController.searchBar.text!)
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        // do some stuff
//    }
}

