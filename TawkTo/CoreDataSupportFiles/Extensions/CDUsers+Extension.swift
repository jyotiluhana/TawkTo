//
//  CDUsers+Extension.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 17/10/21.
//

import Foundation

extension CDUsers {
    
    func convertToUser() -> Users {
        return Users(
            login: self.login,
            id: Int(self.id),
            node_id: self.node_id,
            avatar_url: self.avatar_url,
            gravatar_id: self.gravatar_id,
            url: self.url,
            html_url: self.html_url,
            followers_url: self.followers_url,
            following_url: self.following_url,
            gists_url: self.gists_url,
            starred_url: self.starred_url,
            subscriptions_url: self.subscriptions_url,
            organizations_url: self.organizations_url,
            repos_url: self.repos_url,
            events_url: self.events_url,
            received_events_url: self.received_events_url,
            type: self.type,
            site_admin: self.site_admin,
            hasNote: false,
            name: self.name,
            company: self.company,
            blog: self.blog,
            location: self.location,
            email: self.email,
            hireable: self.hireable,
            bio: self.bio,
            twitter_username: self.twitter_username,
            public_repos: Int(self.public_repos),
            public_gists: Int(self.public_gists),
            followers: Int(self.followers),
            following: Int(self.following),
            created_at: self.created_at,
            updated_at: self.updated_at,
            is_visited: self.is_visited,
            notes: self.toNotes?.convertToNote()
        )
    }
}
