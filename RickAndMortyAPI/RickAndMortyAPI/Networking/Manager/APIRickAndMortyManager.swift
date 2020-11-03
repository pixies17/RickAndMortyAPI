//
//  APIRickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

struct CharactersRequest: APIRequest {    
    typealias Response = CharacterList
    
    var path: String {
        return "character/"
    }
    
    var parameters: [String: Any]
}
