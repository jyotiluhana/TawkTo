//
//  UserDetailsViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 15/10/21.
//

import Foundation

protocol UserDetailsDataProvider {
    func didFetchUserDetails()
}

class UserDetailsViewModel {
    
    var userDetailsService = UserDetailsServices()
    var delegate : UserDetailsDataProvider?
    var userCellViewModel : UserCellViewModel?

    var users = Users() {
        didSet {
            self.delegate?.didFetchUserDetails()
        }
    }
    
//    var userCellModel = UserCellViewModel() {
//        didSet {
//            self.delegate?.didFetchUserDetails()
//        }
//    }

    
    func fetchUserDetails(withUsername username: String) {
        userDetailsService.delegate = self
        userDetailsService.fetchUserDetails(username: username)
    }
    
    func getUserDetails() -> UserCellViewModel {
        return userCellViewModel ?? UserCellViewModel(users)
    }
}

extension UserDetailsViewModel : UserDetailsResponse {
    func didReceiveUserDetailsResponse(_ response: Users) {
        self.userCellViewModel = UserCellViewModel(response)
        self.users = response
    }
}
