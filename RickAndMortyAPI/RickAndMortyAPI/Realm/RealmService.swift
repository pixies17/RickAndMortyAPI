//
//  RealmService.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 05.11.2020.
//

import Foundation
import RealmSwift

final class RealmService {
    
    static let shared = RealmService()
    
    let realm = try! Realm()
    
    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    private init() {}
}
