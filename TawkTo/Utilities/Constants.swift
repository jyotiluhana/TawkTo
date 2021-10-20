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

extension HTTPNetworkError {
    static let STR_SOMETHING_WENT_WRONG = "Something went wrong please try again later"
    static let STR_DECODING_FAIL_MESSAGE = "Unexpected result.Please try Again after Some Time"
    static let STR_NO_DATA_MESSAGE = "There is no releted data found"
    static let STR_UNAUTHORISED_MESSAGE = "Invalid user id or password."
    static let STR_REQUEST_TIME_OUT_MESSAGE = "Request Time Out. Please Try Again after Some Time"
    static let STR_SERVER_ERROR_MESSAGE = "Internal server error"
    static let STR_INTERNAL_SERVER_ERROR_MESSAGE = "Something went wrong please try again later"
    static let STR_SESSION_EXPIRE_MESSAGE = "We are unable to verify you Please Logout & Login Again"
    static let STR_NO_NETWORK_MESSAGE = "It seems you don't have Internet Connection."
    static let STR_APPLEID_INVALID_MESSAGE = "We are unable to authorise with current apple id. please try again"
    static let STR_GOOGLE_ERROR_MESSAGE = "We are unable to authorise with current google account. please try again"
    static let STR_FACEBOOK_ERROR_MESSAGE = "We are unable to authorise with current facebook account. please try again"
}

