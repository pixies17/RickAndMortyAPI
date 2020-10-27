//
//  Router.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
                #warning("надо сразу тут декодить данные, тебе незачем передавать сырую data для каждлого запроса и сразу возвращать готовые данные: либо ошибку либо сразу данные")
                #warning("для этого надо посмотреть структуру Result")
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    #warning("по сути ты тут только добавлешь тип httpMethod, а если будут входные параметры?")
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
//        var request = URLRequest(url: URL(string: route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
//        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        var request = route.request
        
        request.httpMethod = route.HTTPMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

