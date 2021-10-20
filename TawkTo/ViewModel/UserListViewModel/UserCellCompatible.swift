//
//  UserCellViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation
import UIKit

//All the cell of the UserList tableview must confirm to UserCellCompatible
protocol UserCellCompatible {
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

protocol Configurable {
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
    
}
