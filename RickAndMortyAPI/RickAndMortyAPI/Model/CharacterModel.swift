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

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let imageUrl: String
    let characterUrl: String
        
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
    let name: String
    let url: String
}

final class CharacterModelRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var status = ""
    @objc dynamic var species = ""
    @objc dynamic var type = ""
    @objc dynamic var gender = ""
//    @objc dynamic var origin: Origin? = nil
    @objc dynamic var imageUrl = ""
    @objc dynamic var characterUrl = ""
}
