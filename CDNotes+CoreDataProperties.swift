//
//  CDNotes+CoreDataProperties.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 16/10/21.
//
//

import Foundation
import CoreData


extension CDNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNotes> {
        return NSFetchRequest<CDNotes>(entityName: "CDNotes")
    }

    @NSManaged public var id: Int32
    @NSManaged public var note: String?
    @NSManaged public var toUsers: CDUsers?

}

//extension CDNotes : Identifiable {
//
//}
