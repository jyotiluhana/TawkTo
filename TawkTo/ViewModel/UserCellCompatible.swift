//
//  UserCellViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation
import UIKit

protocol UserCellCompatible {
    
    var reuseIdentifier: String { get }
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

