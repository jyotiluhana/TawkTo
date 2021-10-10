//
//  Users.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation

struct Users {
    var id: Int
    var username: String
    var userDetails: String
    var hasNote: Bool
}

protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
    
}
