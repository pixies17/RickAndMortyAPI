//
//  NetworkManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

#warning("здесь нужен не failure(String), а создать кастомную ошибку, где будут описаные возможные варианты ошибок")
//например
//enum Error: Swift.Error {
//case invalidURL
//case encoding
//case server(statusCode: Int)
//case decoding
//}
struct NetworkManager {
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
