//
//  NoteDataRepository.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation
import CoreData

protocol NoteRepository: BaseRepository {}

struct NoteDataRepository: NoteRepository {
    func create(record: Note) {
        let cdNote = CDNotes(context: PersistentStorage.shared.context)
        cdNote.id = Int32(record.id ?? 0)
        cdNote.note = record.note

        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Note]? {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDNotes.self)
        guard records != nil && records?.count != 0 else {return nil}
        
        var note : [Note] = []
        records?.forEach({ (cdNote) in
            note.append(cdNote.convertToNote())
        })
        
        return note
    }
    
    func get(byIdentifier id: Int) -> Note? {
        let result = self.getCdNote(byId: id)
        guard result != nil else {return nil}

        return result!.convertToNote()
    }
    
    func update(record: Note) -> Bool {
        let cdNote = self.getCdNote(byId: record.id ?? 0)
        guard cdNote != nil else {return false}
        
        cdNote?.id = Int32(record.id ?? 0)
        cdNote?.note = record.note
        
        PersistentStorage.shared.saveContext()

        return true
    }
    
    func delete(byIdentifier id: Int) -> Bool {
        let cdNote = self.getCdNote(byId: id)
        guard cdNote != nil else {return false}

        PersistentStorage.shared.context.delete(cdNote!)
        PersistentStorage.shared.saveContext()

        return true
    }
    
    private func getCdNote(byId id: Int) -> CDNotes?
    {
        let fetchRequest = NSFetchRequest<CDNotes>(entityName: "CDNotes")
        let predicate = NSPredicate(format: "id == '\(id)'")
        fetchRequest.predicate = predicate

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }
    
    typealias T = Note
    
}
