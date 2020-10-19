//
//  APIRickAndMortyManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

enum CharactersAPI: EndPointType {
    var HTTPMethod: HTTPMethod {
        return .get
    }
    
    case all
    case forPage(page: Int)
    case singleCharacter(id: Int)
    
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var URLForPage: URL {
        return URL(string: "https://rickandmortyapi.com/api/character/?page=1")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "character"
        case .forPage(let page):
            return "character/?page=\(page)"
        case .singleCharacter(let id):
            return "character/\(id)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
    }
}
//
//final class APIRicAndMoryManager: APIManager {
//    let sessionConfiguration: URLSessionConfiguration
//    lazy var session: URLSession = {
//        return URLSession(configuration: sessionConfiguration.self)
//    }()
//        
//    init(sessionConfiguration: URLSessionConfiguration) {
//        self.sessionConfiguration = sessionConfiguration
//    }
//    
//    func getCharacters(page: Int, completion: @escaping (APIResult<CharacterList>) -> Void) {
//        let request = CharactersAPI.forPage(page: 1).request
//        
//        fetch(request: request) { (json) -> [String: Any] in
//            if let dict = json["results"] as? [String: Any] {
//                return dict
//            } else {
//                return nil
//            }
//        }, completionHandler: completion)
//    }
//}
