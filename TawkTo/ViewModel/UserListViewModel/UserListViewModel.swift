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
    
    var userListService = UserListServices()
    var userCellViewModel = [UserCellViewModel]()
    private var userManager = UserManager()
    private var noteManager = NoteManager()
    var isLoading = false
    var delegate : UserListDataProvider?
    
    
    var users = [Users]() {
        didSet {
            userCellViewModel = users.indices.map({  UserCellViewModel(users[$0]) })
            let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            debugPrint(documentDirectoryPath[0])
            for user in users {
                userManager.create(record: user)
            }
            self.isLoading = false
            self.delegate?.didUpdateUserData()
        }
    }
    
    func getUserData(_ sinceValue: Int) {
        self.userCellViewModel.removeAll()
        self.users.removeAll()
        self.isLoading = true
        userListService.delegate = self
        userListService.fetchUserList(since)
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
        
        var userList = [Users]()
        for var user in response {
            if let result = self.noteManager.fetchNoteById(recordId: user.id!) {
                user.notes = result
            } else {
                user.notes = nil
            }
            userList.append(user)
        }
        self.users.append(contentsOf: userList)
    }
}
