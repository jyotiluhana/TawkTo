//
//  UserListViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 13/10/21.
//

import Foundation

protocol UserListDataProvider {
    func didUpdateUserData()
    func didGetErrorInFetchingUserList(error: HTTPNetworkError)
}

class UserListViewModel {
    
    private var since : Int = 0
    
    var userListService = UserListServices()
    var userCellViewModel = [UserCellViewModel]()
    private var _userManager = UserManager()
    private var _noteManager = NoteManager()
    var isLoading = false
    var isSearchModeOn = false
    var delegate : UserListDataProvider?
    
    
    var users = [Users]() {
        didSet {
            userCellViewModel = users.indices.map({  UserCellViewModel(users[$0]) })
//            let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            debugPrint(documentDirectoryPath[0])
            for user in users {
                _userManager.create(record: user)
            }
            self.isLoading = false
            self.delegate?.didUpdateUserData()
        }
    }
    
    func initiateDataToDisplay() {
        self.getAllUserFromDB()
        if NetworkListner.shared.isNetworkAvailable {
            self.getUserData()
        } else {
            self.getAllUserFromDB()
        }
    }
    
    func getUserData() {
        self.userCellViewModel.removeAll()
        self.users.removeAll()
        self.isLoading = true
        since = 0
        userListService.delegate = self
        userListService.fetchUserList(withSince: 0)
        userListService.onErrorHandling = { error in
            self.delegate?.didGetErrorInFetchingUserList(error: error)
        }
    }
    
    func loadMoreUsers() {
        since = since + 1
        self.isLoading = true
        userListService.delegate = self
        userListService.fetchUserList(withSince: since)
        userListService.onErrorHandling = { error in
            self.delegate?.didGetErrorInFetchingUserList(error: error)
        }
    }
    
    func getCount() -> Int {
        return self.userCellViewModel.count
    }
    
    func getModelForIndex(_ index: Int) -> UserCellViewModel {
        return userCellViewModel[index]
    }
    
    func fetchFilteredUser(withText text: String) {
        guard let result = self._userManager.fetchFilterUser(byName: text) else { return }
        var userList = [Users]()
        for var user in result {
            if let result = self._noteManager.fetchNoteById(recordId: user.id!) {
                user.notes = result
            } else {
                user.notes = nil
            }
            if let record = self._userManager.fetchUserById(id: user.id!) {
                user.is_visited = record.is_visited
            }
            userList.append(user)
        }
        
        self.users.removeAll()
        self.users.append(contentsOf: userList)
    }
    
    func getAllUserFromDB() {
        guard let users = self._userManager.getAllUsers() else {return}
        self.users.removeAll()
        self.userCellViewModel.removeAll()
        self.users.append(contentsOf: users)
    }
}

extension UserListViewModel: UserListResponse {
    func didRecieveUserListResponse(_ response: [Users]) {
        
        var userList = [Users]()
        for var user in response {
            if let result = self._noteManager.fetchNoteById(recordId: user.id!) {
                user.notes = result
            } else {
                user.notes = nil
            }
            if let record = self._userManager.fetchUserById(id: user.id!) {
                user.is_visited = record.is_visited
            }
            userList.append(user)
        }
        self.users.append(contentsOf: userList)
    }
}
