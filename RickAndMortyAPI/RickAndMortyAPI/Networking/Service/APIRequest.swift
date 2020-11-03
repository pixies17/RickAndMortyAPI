//
//  APIRequest.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String { get }
    var parameters: [String: Any] { get }
    var httpMethod: HTTPMethod { get }
}

extension APIRequest {
    var httpMethod: HTTPMethod { .get }
}
