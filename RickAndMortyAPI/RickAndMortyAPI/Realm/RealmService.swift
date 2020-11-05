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
    
    func load<T: Object>(_ object: T) -> Results<T> {
        let objects = realm.objects(T.self)
        
        return objects
    }
    
    private init() {}
}
