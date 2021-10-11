//
//  ReusableView+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 10/10/21.
//

import Foundation
import UIKit

typealias Reusable =  UITableViewCell & Identifiable

protocol Identifiable : AnyObject {
    static var defaultIdentifier: String { get }
}

extension Identifiable where Self: UITableViewCell {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView   {
    func enroll(_ reusable: Reusable.Type) {
        self.register(reusable, forCellReuseIdentifier: reusable.defaultIdentifier)
    }
}

