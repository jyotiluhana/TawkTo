//
//  UserDataRepository.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 16/10/21.
//

import Foundation
import CoreData

protocol UserRepository: BaseRepository {}

struct UserDataRepository: UserRepository {
    
    func create(record: Users) {
        let user = self.getCdUser(byId: record.id ?? 0)
        guard user == nil else {return}
        
        let cdUser = CDUsers(context: PersistentStorage.shared.context)
        cdUser.id = Int32(record.id ?? 0)
        cdUser.login = record.login
        cdUser.node_id = record.node_id
        cdUser.avatar_url = record.avatar_url
        cdUser.gravatar_id = record.gravatar_id
        cdUser.url = record.url
        cdUser.html_url = record.html_url
        cdUser.followers_url = record.followers_url
        cdUser.following_url = record.following_url
        cdUser.gists_url = record.gists_url
        cdUser.starred_url = record.starred_url
        cdUser.subscriptions_url = record.subscriptions_url
        cdUser.organizations_url = record.organizations_url
        cdUser.repos_url = record.repos_url
        cdUser.events_url = record.events_url
        cdUser.received_events_url = record.received_events_url
        cdUser.type = record.type
        cdUser.site_admin = record.site_admin ?? false
        
        cdUser.name = record.name
        cdUser.company = record.company
        cdUser.blog = record.blog
        cdUser.location = record.location
        cdUser.email = record.email
        cdUser.hireable = record.hireable
        cdUser.bio = record.bio
        cdUser.twitter_username = record.twitter_username
        cdUser.public_repos = Int32(record.public_repos ?? 0)
        cdUser.public_gists = Int32(record.public_gists ?? 0)
        cdUser.followers = Int32(record.followers ?? 0)
        cdUser.following = Int32(record.following ?? 0)
        cdUser.created_at = record.created_at
        cdUser.updated_at = record.updated_at
        cdUser.is_visited = record.is_visited ?? false
        

        if(record.notes != nil)
        {
            let cdNote = CDNotes(context: PersistentStorage.shared.context)
            cdNote.note = record.notes?.note
            cdNote.id = Int32(record.notes?.id ?? 0)
            
            cdUser.toNotes = cdNote
        }

        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Users]? {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDUsers.self)
        guard records != nil && records?.count != 0 else {return nil}
        
        var users : [Users] = []
        records?.forEach({ (cdUser) in
            users.append(cdUser.convertToUser())
        })
        
        return users
    }
    
    func get(byIdentifier id: Int) -> Users? {
        let result = self.getCdUser(byId: id)
        guard result != nil else {return nil}

        return result!.convertToUser()
    }
    
    func update(record: Users) -> Bool {
        let cdUser = self.getCdUser(byId: record.id ?? 0)
        guard cdUser != nil else {return false}

        cdUser?.id = Int32(record.id ?? 0)
        cdUser?.login = record.login
        cdUser?.node_id = record.node_id
        cdUser?.avatar_url = record.avatar_url
        cdUser?.gravatar_id = record.gravatar_id
        cdUser?.url = record.url
        cdUser?.html_url = record.html_url
        cdUser?.followers_url = record.followers_url
        cdUser?.following_url = record.following_url
        cdUser?.gists_url = record.gists_url
        cdUser?.starred_url = record.starred_url
        cdUser?.subscriptions_url = record.subscriptions_url
        cdUser?.organizations_url = record.organizations_url
        cdUser?.repos_url = record.repos_url
        cdUser?.events_url = record.events_url
        cdUser?.received_events_url = record.received_events_url
        cdUser?.type = record.type
        cdUser?.site_admin = record.site_admin ?? false
        
        cdUser?.name = record.name
        cdUser?.company = record.company
        cdUser?.blog = record.blog
        cdUser?.location = record.location
        cdUser?.email = record.email
        cdUser?.hireable = record.hireable
        cdUser?.bio = record.bio
        cdUser?.twitter_username = record.twitter_username
        cdUser?.public_repos = Int32(record.public_repos ?? 0)
        cdUser?.public_gists = Int32(record.public_gists ?? 0)
        cdUser?.followers = Int32(record.followers ?? 0)
        cdUser?.following = Int32(record.following ?? 0)
        cdUser?.created_at = record.created_at
        cdUser?.updated_at = record.updated_at
        cdUser?.is_visited = record.is_visited ?? false

        PersistentStorage.shared.saveContext()

        return true
    }
    
    func delete(byIdentifier id: Int) -> Bool {
        let cdUser = getCdUser(byId: id)
        guard cdUser != nil else {return false}

        PersistentStorage.shared.context.delete(cdUser!)
        PersistentStorage.shared.saveContext()

        return true
    }
    
    func searchUser(byName name: String) -> [Users]? {
        let fetchRequest = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        let predicate = NSPredicate(format: "login contains[c] '\(name)'")
        fetchRequest.predicate = predicate
        
        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        
        var users : [Users] = []
        result.forEach { (cdUser) in
            users.append(cdUser.convertToUser())
        }
        
        return users
    }
    
    private func getCdUser(byId id: Int) -> CDUsers?
    {
        let fetchRequest = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        let predicate = NSPredicate(format: "id == '\(id)'")
        fetchRequest.predicate = predicate

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }

    typealias T = Users
        
}
