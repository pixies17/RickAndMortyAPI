//
//  EndPointType.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

#warning("сделать протокол APIRequest в котором будут хранится url, httpmethod и входные параметры если они нужны")
protocol EndPointType {
    var baseURL: URL { get }
    var URLForPage: URL { get }
    var path: String { get }
    var HTTPMethod: HTTPMethod { get }
    var request: URLRequest { get }
}
