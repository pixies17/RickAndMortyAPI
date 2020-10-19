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
        case image
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try container.decode(Origin.self, forKey: .origin)
        imageUrl = try container.decode(String.self, forKey: .image)
        characterUrl = try container.decode(String.self, forKey: .url)
        
//        dict["id"] = id
//        dict["name"] = name
//        dict["status"] = status
//        dict["species"] = species
//        dict["type"] = type
//        dict["gender"] = gender
//        dict["origin"] = origin
//        dict["imageUrl"] = imageUrl
//        dict["CharacterUrl"] = characterUrl
    }
}

struct Origin: Decodable {
    let name: String
    let url: String
}
