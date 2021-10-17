//
//  UserManager.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation

struct UserManager {
    
    private let _userRepository : UserDataRepository = UserDataRepository()
    
    func create(record: Users)
    {
        var newRecord = record
        if (validateNote(note: newRecord.notes) == false) {
            newRecord.notes = nil
        }
        _userRepository.create(record: newRecord)

    }

    func getAllUsers() -> [Users]?
    {
        return _userRepository.getAll()
    }
    
    func fetchUserById(recordId: Int) -> Users? {
        guard let user = _userRepository.get(byIdentifier: recordId) else { return nil }
        return user
    }

    func deleteUser(byIdentifier id: Int) -> Bool
    {
        return _userRepository.delete(byIdentifier: id)
    }

    func updateUser(record: Users) -> Bool
    {
        return _userRepository.update(record: record)
    }
    
    
    private func validateNote(note: Note?) -> Bool
    {
        if(note == nil || note?.note?.isEmpty == true)
        {
            return false
        }

        return true
    }
}
