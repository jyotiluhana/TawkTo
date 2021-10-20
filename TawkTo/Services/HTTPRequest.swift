//
//  HTTPRequest.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import Foundation

protocol Request {
    var url: URL { get set }
    var method: HTTPMethods {get set}
}

public struct HTTPRequest : Request {
    var url: URL
    var method: HTTPMethods
    var requestBody: Data? = nil

    init(withUrl url: URL, forHttpMethod method: HTTPMethods, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
