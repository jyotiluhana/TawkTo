//
//  BaseRepository.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 16/10/21.
//

import Foundation

protocol BaseRepository {

    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: Int) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: Int) -> Bool
}
