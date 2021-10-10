//
//  USerListPresenter.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation
import UIKit

class UserCellViewModel: UserCellCompatible {

    var reuseIdentifier: String {
        return "UserListCell"
    }
    
    let id: Int
    let username: String
    let userDetails: String
    let hasNote: Bool
    
    init(_ user: Users) {
        self.id = user.id
        self.username = user.username
        self.userDetails = user.userDetails
        self.hasNote = user.hasNote
    }
      
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if ((indexPath.row + 1) % 4 == 0) {
            //return Inverted Cell
            if hasNote {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListNoteInvertedCell.defaultIdentifier, for: indexPath) as! UserListNoteInvertedCell
                cell.configureWithModel(self)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListInvertedCell.defaultIdentifier, for: indexPath) as! UserListInvertedCell
                cell.configureWithModel(self)
                return cell
            }
            
        } else {
            //return Normal cell
            if hasNote {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListNoteCell.defaultIdentifier, for: indexPath) as! UserListNoteCell
                cell.configureWithModel(self)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.defaultIdentifier, for: indexPath) as! UserListCell
                cell.configureWithModel(self)
                return cell            }
        }
    }
    
}
