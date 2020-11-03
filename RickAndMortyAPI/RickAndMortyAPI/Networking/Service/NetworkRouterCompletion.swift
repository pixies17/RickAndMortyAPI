//
//  NetworkRouterCompletion.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation
public typealias NetworkRouterCompletion<Data> = (Result<Data, Error>) -> Void

protocol NetworkRouter: class {
    #warning("функция кидает реквест, но по названию это непонятно + у тебя параметр route, хотя ты кидаешь туда APIRequest")
    func request<T: APIRequest>(_ route: T, completion: @escaping NetworkRouterCompletion<T.Response>)
}
