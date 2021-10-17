//
//  UserDetailsViewModel.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 15/10/21.
//

import Foundation

protocol UserDetailsDataProvider {
    func didFetchUserDetails()
    func didUpdateNote()
}

class UserDetailsViewModel {
    
    var userDetailsService = UserDetailsServices()
    var delegate : UserDetailsDataProvider?
    private var noteManager = NoteManager()
    var isLoading = false
    var userCellViewModel : UserCellViewModel?
    
    var users = Users() {
        didSet {
            self.userCellViewModel = UserCellViewModel(users)
            isLoading = false
            self.delegate?.didFetchUserDetails()
        }
    }
    
    func fetchUserDetails(withUsername username: String) {
        isLoading = true
        userDetailsService.delegate = self
        userDetailsService.fetchUserDetails(username: username)
    }
    
    func getUserDetails() -> UserCellViewModel {
        return userCellViewModel ?? UserCellViewModel(users)
    }
    
    func fetchUserNoteForId(_ id: Int) -> Note? {
        guard let result = self.noteManager.fetchNoteById(recordId: id) else { return nil }
        return result
    }
    
    func addUserNotes(note: String) {
        //        self.users.notes?.note = note
        //        self.users.notes?.id = self.users.id
        let newNote = Note(id: users.id, note: note)
        if let id = users.id {
            let record = self.noteManager.fetchNoteById(recordId: id)
            if record != nil {
                if !note.isEmpty {
                    let result = self.noteManager.updateNote(record: newNote)
                    if result {
                        self.userCellViewModel?.notes = newNote
                        self.delegate?.didUpdateNote()
                    }
                } else {
                    let result = self.noteManager.deleteNote(byIdentifier: id)
                    if result {
                        self.userCellViewModel?.notes = nil
                        self.delegate?.didUpdateNote()
                    }
                }
            } else {
                if !note.isEmpty {
                    self.noteManager.create(record: newNote)
                    self.userCellViewModel?.notes = newNote
                    self.delegate?.didUpdateNote()
                }
            }
        }
    }
    
}

extension UserDetailsViewModel : UserDetailsResponse {
    func didReceiveUserDetailsResponse(_ response: Users) {
        self.users = response
    }
}
