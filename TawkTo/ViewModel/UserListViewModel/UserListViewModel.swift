//
//  UserListViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 13/10/21.
//

import Foundation

protocol UserListDataProvider {
    func didUpdateUserData()
}

class UserListViewModel {
    
    private var since : Int = 0
    
    var userListCoordinator = UserListCoordinator()
    var userCellViewModel = [UserCellViewModel]()
    var delegate : UserListDataProvider?
    
    var users = [Users]() {
        didSet {
            userCellViewModel.removeAll()
            userCellViewModel = users.indices.map({  UserCellViewModel(users[$0]) })
            self.delegate?.didUpdateUserData()
        }
    }
    
    func getUserData(_ sinceValue: Int) {
        userListCoordinator.delegate = self
        userListCoordinator.fetchUserList(since)
    }
    
    func getCount() -> Int {
        return self.userCellViewModel.count
    }
    
    func getModelForIndex(_ index: Int) -> UserCellViewModel {
        return userCellViewModel[index]
    }
}

extension UserListViewModel: UserListResponse {
    func didRecieveUserListResponse(_ response: [Users]) {
        self.users.append(contentsOf: response)
    }
}
