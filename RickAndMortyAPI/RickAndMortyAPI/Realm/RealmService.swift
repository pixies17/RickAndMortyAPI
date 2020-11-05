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
    
    #warning("пофиксил, ты зачем-то объект передавал, а тебе надо было просто тип указать")
    func load<T: Object>(_ object: T.Type) -> [T] {
        let objects = realm.objects(T.self)
        #warning("сделал чтобы каждый раз не форматировать данные")
        return objects.map{ $0 }
    }
    
    private init() {}
}
