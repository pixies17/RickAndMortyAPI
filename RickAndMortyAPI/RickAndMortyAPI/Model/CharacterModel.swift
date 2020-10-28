//
//  CharacterModel.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 13.10.2020.
//

import Foundation

struct CharacterList: Decodable {
    let results: [CharacterModel]
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

struct Origin: Decodable {
    var name: String
    var url: String
}
