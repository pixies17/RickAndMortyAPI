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
    
    func load<T: Object>(_ object: T.Type) -> [T] {
        let objects = realm.objects(T.self)
        return objects.map{ $0 }
    }
    
    func isEntityExist<T: Object>(in object: T.Type, id: Int) -> Bool {
        guard realm.object(ofType: object, forPrimaryKey: id) == nil else { return true }
        return false
    }
    
    private init() {}
}
