//
//  APIRickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

struct CharactersAPI: APIRequest {
    typealias Response = CharacterList
    
    var path: String {
        return "character/"
    }
    
    var page: Int
    
    var parameters: [String : Int] {
        ["page": page]
    }
    
    var HTTPMethod: HTTPMethod { .get }
}
