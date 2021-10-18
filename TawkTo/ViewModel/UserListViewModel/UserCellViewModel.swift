//
//  USerListPresenter.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation
import UIKit

class UserCellViewModel: UserCellCompatible {
    
    fileprivate var users: Users?

    var id: Int {
        get {
            return users?.id ?? 0
        }
        set {
            users?.id = newValue
        }
    }
    var username: String {
        get {
            return users?.login ?? ""
        }
        set {
            users?.login = newValue
        }
    }
    var avatar_url: String {
        get {
            return users?.avatar_url ?? ""
        }
        set {
            users?.avatar_url = newValue
        }
    }
    var url: String {
        get {
            return users?.url ?? ""
        }
        set {
            users?.url = newValue
        }
    }
    var note: String {
        get {
            return users?.notes?.note ?? ""
        }
        set {
            users?.notes?.note = newValue
        }
    }
    var note_id: Int {
        get {
            return users?.notes?.id ?? 0
        }
        set {
            users?.notes?.id = Int(newValue)
        }
    }
    var hasNote: Bool {
        get {
            return users?.hasNote ?? false
        }
        set {
            let note = users?.notes?.note ?? ""
            users?.hasNote = note.isEmpty ? false : true
        }
    }
    var name: String {
        get {
            return "Name: \(users?.name ?? "N/A")"
        }
        set {
            users?.name = newValue
        }
    }
    var company: String {
        get {
            return "Company: \(users?.company ?? "N/A")"
        }
        set {
            users?.company = newValue
        }
    }
    var blog: String {
        get {
            return "Blog: \(users?.blog ?? "N/A")"
        }
        set {
            users?.blog = newValue
        }
    }
    var followers: String {
        get {
            return "Followers: \(users?.followers ?? 0)"
        }
        set {
            users?.followers = Int(newValue)
        }
    }
    var following: String {
        get {
            return "Following: \(users?.following ?? 0)"
        }
        set {
            users?.following = Int(newValue)
        }
    }
    var is_visited: Bool {
        get {
            return users?.is_visited ?? false
        }
        set {
            users?.is_visited = newValue
        }
    }
    
    var notes: Note? {
        get {
            return users?.notes ?? nil
        }
        set {
            users?.notes = newValue
        }
    }
    
    init(_ user: Users) {
        self.users = user
    }
      
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if ((indexPath.row + 1) % 4 == 0) {
            //return Inverted Cell
            if users?.notes != nil {
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
            if users?.notes != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListNoteCell.defaultIdentifier, for: indexPath) as! UserListNoteCell
                cell.configureWithModel(self)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.defaultIdentifier, for: indexPath) as! UserListCell
                cell.configureWithModel(self)
                return cell
            }
        }
    }
}

