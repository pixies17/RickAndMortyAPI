//
//  NetworkManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

public enum Error: Swift.Error {
    case failed
    case encoding
    case decoding
    case incorrectData
}

struct NetworkManager {
    enum Result<Error> {
        case success
        case failure(Error)
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299:
            return .success
            #warning("failed??????? serverError лучше")
        default: return .failure(.failed)
        }
    }
}
