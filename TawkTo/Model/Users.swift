//
//  Users.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 09/10/21.
//

import Foundation

struct Users: Codable {
    var login: String = ""
    var id: Int = 0
    var node_id: String = ""
    var avatar_url: String = ""
    var gravatar_id: String = ""
    var url: String = ""
    var html_url: String = ""
    var followers_url: String = ""
    var following_url: String = ""
    var gists_url: String = ""
    var starred_url: String = ""
    var subscriptions_url: String = ""
    var organizations_url: String = ""
    var repos_url: String = ""
    var events_url: String = ""
    var received_events_url: String = ""
    var type: String = ""
    var site_admin: String = ""
}

protocol Configurable {
    
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
    
}
