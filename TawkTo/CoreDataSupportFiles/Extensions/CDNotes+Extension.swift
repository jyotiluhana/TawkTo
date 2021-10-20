//
//  CDNote+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation

extension CDNotes {
    
    func convertToNote() -> Note {
        return Note(
            id: Int(self.id),
            note: self.note
        )
    }
}
