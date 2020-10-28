//
//  APIRickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

struct CharactersAPI: APIRequest {
    typealias Response = [CharacterModel]
    
    var path: String {
        return "character/"
    }
    
    var HTTPMethod: HTTPMethod { .get }
    
//    let page: Int?
//
//    init(page: Int? = nil) {
//        self.page = page
//    }
}
//    var HTTPMethod: HTTPMethod {
//        return .get
//    }
//
//    case all
//    case forPage(page: Int)
//    case singleCharacter(id: Int)
//
//    var baseURL: URL {
//        return URL(string: "https://rickandmortyapi.com/api/")!
//    }
//
//    var URLForPage: URL {
//        return URL(string: "https://rickandmortyapi.com/api/character/?page=1")!
//    }
//
//    var path: String {
//        switch self {
//        case .all:
//            return "character"
//        case .forPage(let page):
//            return "character/?page=\(page)"
//        case .singleCharacter(let id):
//            return "character/\(id)"
//        }
//    }
//
//    var request: URLRequest {
//        let url = URL(string: path, relativeTo: baseURL)
//        return URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
//    }
