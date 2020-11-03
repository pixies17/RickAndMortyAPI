//
//  NetworkRouterCompletion.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation
public typealias NetworkRouterCompletion<Data> = (Result<Data, Error>) -> Void

protocol NetworkRouter: class {
    func send<T: APIRequest>(_ request: T, completion: @escaping NetworkRouterCompletion<T.Response>)
}
