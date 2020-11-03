//
//  NetworkManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

struct NetworkManager {
    #warning("зачем здесь статик?")
    #warning("почему тут хардкод на CharactersAPI?")
    #warning("надо при ините этой структуры прокидывать APIRequest")
//    static let router = Router<<#EndPoint: APIRequest#>>()
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        default: return .failure("Something goes wrong")
        }
    }
}
