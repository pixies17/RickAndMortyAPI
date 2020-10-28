//
//  CharacterModel.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import Foundation
import RealmSwift
#warning("лучше разбить на несколько файлов чтобы не искать кучу файлов")
struct CharacterList<Results: Decodable>: Decodable {
    let results: Results
}

struct CharacterModel: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var imageUrl: String
    var characterUrl: String
        
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
}

@objc class Origin: NSObject, Decodable {
    @objc dynamic var name: String
    @objc dynamic var url: String
}

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
