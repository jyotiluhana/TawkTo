//
//  NoteManager.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation

struct NoteManager {
    
    private let _noteRepository : NoteDataRepository = NoteDataRepository()

    func create(record: Note)
    {
        _noteRepository.create(record: record)
    }

    func getAllNote() -> [Note]?
    {
        return _noteRepository.getAll()
    }
    
    func fetchNoteById(recordId: Int) -> Note? {
        guard let note = _noteRepository.get(byIdentifier: recordId) else { return nil }
        return note
    }

    func deleteNote(byIdentifier id: Int) -> Bool
    {
        return _noteRepository.delete(byIdentifier: id)
    }
    
    func updateNote(record: Note) -> Bool
    {
        return _noteRepository.update(record: record)
    }

}
