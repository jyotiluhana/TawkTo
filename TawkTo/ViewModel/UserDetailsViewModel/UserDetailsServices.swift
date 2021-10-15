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
    
    func fetchUserDetails(username: String) {
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
                break
            }
        }
    }
}
