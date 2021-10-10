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
    
    //MARK: View load methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
        self.addConstraints()
        
        let viewCells: [Reusable.Type] = [UserListCell.self, UserListInvertedCell.self, UserListNoteCell.self, UserListNoteInvertedCell.self]

        for viewCell in viewCells {
            tableView.register(viewCell)
        }
        
//        self.tableView.register(UserListCell.self, forCellReuseIdentifier: "UserListCell")
//        self.tableView.register(UserListInvertedCell.self, forCellReuseIdentifier: "UserListInvertedCell")
//        self.tableView.register(UserListNoteCell.self, forCellReuseIdentifier: "UserListNoteCell")
//        self.tableView.register(UserListNoteInvertedCell.self, forCellReuseIdentifier: "UserListNoteInvertedCell")

        
        userCellViewModel.append(UserCellViewModel(Users(id: 1, username: "Jyoti1", userDetails: "Jyoti User Details1", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 2, username: "Jyoti2", userDetails: "Jyoti User Details2", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 3, username: "Jyoti3", userDetails: "Jyoti User Details3", hasNote: true)))
        userCellViewModel.append(UserCellViewModel(Users(id: 4, username: "Jyoti4", userDetails: "Jyoti User Details4", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 5, username: "Jyoti5", userDetails: "Jyoti User Details5", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 6, username: "Jyoti6", userDetails: "Jyoti User Details6", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 7, username: "Jyoti7", userDetails: "Jyoti User Details7", hasNote: false)))
        userCellViewModel.append(UserCellViewModel(Users(id: 7, username: "Jyoti8", userDetails: "Jyoti User Details8", hasNote: true)))
    }
    
    //MARK: View setup
    private func setupView() {
        self.view.addSubview(tableView)
    }

    private func addConstraints() {
        self.tableView.fillToSuperview()
    }

}

extension UITableView {
    func register<T: UITableViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
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

