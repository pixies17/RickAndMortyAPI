//
//  APIRequest.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

#warning("почему int? лучше сразу закладываться на то, что там может быть вообще любой тип")
protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var parameters: [String: Int] { get }
    var HTTPMethod: HTTPMethod { get }
}

#warning("сделай экстеншен на протокол, чтобы все реквесты сразу были типа GET")
