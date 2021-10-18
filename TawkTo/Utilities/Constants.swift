//
//  Constants.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import Foundation

enum HTTPMethods : String {
    case post = "POST"
    case get = "GET"
}

struct APIEndpoint {
    static let users = "users"
}

extension Notification.Name {
    static let offline = Notification.Name(rawValue: "OfflineMode")
    static let online = Notification.Name(rawValue: "OnlineMode")
}
