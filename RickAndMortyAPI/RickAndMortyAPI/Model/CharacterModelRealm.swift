//
//  CharacterModelRealm.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 28.10.2020.
//

import Foundation
import RealmSwift

class CharacterModelRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var species = ""
    @objc dynamic var type = ""
    @objc dynamic var gender = ""
    @objc dynamic var originName = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var characterUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int) {
        self.init()
        
        self.id = id
    }
}
