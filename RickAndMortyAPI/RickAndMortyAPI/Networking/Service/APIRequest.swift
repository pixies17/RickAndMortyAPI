//
//  APIRequest.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var parameters: [String: Int] { get }
    var HTTPMethod: HTTPMethod { get }
}
