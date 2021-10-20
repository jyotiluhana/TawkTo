//
//  HTTPNetworkError.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 11/10/21.
//

import Foundation

public struct HTTPNetworkError : Error
{
    var reason: String? = nil
    let httpStatusCode: Int?
    let requestUrl: URL?
    let requestBody: String?
    let serverResponse: String?
    
    init(withServerResponse response: Data? = nil, forRequestUrl url: URL, withHttpBody body: Data? = nil, errorMessage message: String, forStatusCode statusCode: Int)
    {
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        reason = message.isEmpty || message == "nil" ? self.handleErrorCode(with: 0).errorDescription : message
    }
    
    enum NetworkError: Error{
        
        case decodingFailed
        case noData
        case unauthorised
        case requestTimeout
        case serverError
        case internalError
        case seassionExpire
        case noNetwork
        
        public var errorDescription: String? {
            switch self {
            case .requestTimeout : return HTTPNetworkError.STR_REQUEST_TIME_OUT_MESSAGE
            case .decodingFailed : return HTTPNetworkError.STR_DECODING_FAIL_MESSAGE
            case .noData         : return HTTPNetworkError.STR_NO_DATA_MESSAGE
            case .unauthorised   : return HTTPNetworkError.STR_UNAUTHORISED_MESSAGE
            case .serverError    : return HTTPNetworkError.STR_INTERNAL_SERVER_ERROR_MESSAGE
            case .internalError  : return HTTPNetworkError.STR_INTERNAL_SERVER_ERROR_MESSAGE
            case .seassionExpire : return HTTPNetworkError.STR_SESSION_EXPIRE_MESSAGE
            case .noNetwork      : return HTTPNetworkError.STR_NO_NETWORK_MESSAGE
            }
        }
    }
    
    func handleErrorCode(with errCode:Int)->NetworkError{
        switch errCode {
        case 300...399  :   return .internalError
        case 400...499  :
            switch errCode {
            case    401 : return .unauthorised
            case    403 : return .seassionExpire
            default     : return .requestTimeout
            }
        case 500...599  :   return .serverError
        default         :   return .requestTimeout
        }
    }
    
}


