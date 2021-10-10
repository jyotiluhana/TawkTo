//
//  ReusableView+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 10/10/21.
//

import Foundation
import UIKit

protocol Reusable: AnyObject {
    static var defaultIdentifier: String { get }
    static func register(tableView: UITableView)
}

extension Reusable where Self: UITableViewCell {
    static var defaultIdentifier: String {
        return String(describing: self)
    }

    static func register(tableView: UITableView) {
//        tableView.register(Self.defaultIdentifier.self, forCellReuseIdentifier: Self.defaultIdentifier)
        //TODO: App crash over here. Need to solve
        tableView.register(UINib(nibName: Self.defaultIdentifier, bundle: nil), forCellReuseIdentifier: Self.defaultIdentifier)
    }
}

extension UITableView {
    func register(_ reusable: Reusable.Type) {
        reusable.register(tableView: self)
    }
}

