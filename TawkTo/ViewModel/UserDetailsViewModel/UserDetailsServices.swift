//
//  UserDetailsCoordinator.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 14/10/21.
//

import Foundation

protocol UserDetailsResponse {
    func didReceiveUserDetailsResponse(_ response: Users)
}

class UserDetailsServices {
    
    var delegate: UserDetailsResponse?
    var onErrorHandling : ((HTTPNetworkError) -> Void)?
    
    /// APi call for fetching user details from server
    /// - Parameters:
    ///   - username: pass username as String params
    ///   - completionHandler: Will return User details or error based on the response of API call
    func fetchUserDetails(username: String, completionHandler: ((Result<Bool, HTTPNetworkError>) -> Void)? = nil) {
        let apiService = APIServices.sharedInstance
        let requestUrl = URL(string: "\(apiService.BASE_URL)\(APIEndpoint.users)/\(username)")
        let request = HTTPRequest(withUrl: requestUrl!, forHttpMethod: .get, requestBody: nil)
        apiService.request(httpRequest: request, resultType: Users.self) { (response) in
            switch response {
            case.success(let userResponse):
                if let userResponse = userResponse {
                    self.delegate?.didReceiveUserDetailsResponse(userResponse)
                }
                break
            case .failure(let error):
                print("Error: \(error)")
                self.onErrorHandling?(error)
                break
            }
        }
    }
}
