//
//  UserListPresenter.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 13/10/21.
//

import Foundation
import UIKit

protocol UserListResponse {
    func didRecieveUserListResponse(_ response: [Users])
}

class UserListServices {
    
    var delegate: UserListResponse?
    var onErrorHandling : ((HTTPNetworkError) -> Void)?
    
    /// APi call for fetching user list from server
    /// - Parameters:
    ///   - since: Pass Int params
    ///   - completionHandler: Will return array of Users or error based on the response of API call
    func fetchUserList(withSince since: Int, completionHandler: ((Result<Bool, HTTPNetworkError>) -> Void)? = nil) {
        let apiService = APIServices.sharedInstance
        var params = [String : Any]()
        params["since"] = since
        let requestUrl = URL(string: "\(apiService.BASE_URL)\(APIEndpoint.users)?\(params.queryString)")
        let request = HTTPRequest(withUrl: requestUrl!, forHttpMethod: .get, requestBody: nil)
        apiService.request(httpRequest: request, resultType: [Users].self) { (response) in
            switch response {
            case.success(let userResponse):
                if let userResponse = userResponse {
                    self.delegate?.didRecieveUserListResponse(userResponse)
                }
                break
            case .failure(let error):
                print("Error: \(error)")
                self.onErrorHandling?(error)
                break
            }
        }
    }
    
    func fetchUserDataFromJson() {
        let userData = APIServices.sharedInstance.loadJson(filename: "UserList", responseType: [Users].self)
        if let userResponse = userData {
            self.delegate?.didRecieveUserListResponse(userResponse)
        }
    }
}
