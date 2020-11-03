//
//  CharacterModel.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import Foundation
import RealmSwift

struct CharacterList: Decodable {
    let results: [CharacterModel]
}

class CharacterModel: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var species = ""
    @objc dynamic var type = ""
    @objc dynamic var gender = ""
    var origin: Origin?
    @objc dynamic var imageUrl = ""
    @objc dynamic var characterUrl = ""
        
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case imageUrl = "image"
        case characterUrl = "url"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int) {
        self.init()

        self.id = id
    }
}

struct Origin: Decodable {
    var name = ""
    var url = ""
}
