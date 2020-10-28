//
//  Router.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

class Router<EndPoint: APIRequest>: NetworkRouter {
    private var task: URLSessionTask?
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func request<T: APIRequest>(_ route: T, completion: @escaping NetworkRouterCompletion<T.Response>) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let response = response as? HTTPURLResponse {
                    let result = NetworkManager.handleNetworkResponse(response)
                    
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(error!))
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode(CharacterList.self, from: responseData)
                            completion(.success(apiResponse.results as! T.Response))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let trouble):
                        completion(.failure(trouble as! Error))
                    
                    }
                }
            })
        } catch {
            completion(.failure(error))
        }
        task?.resume()
    }
    
    #warning("по сути ты тут только добавлешь тип httpMethod, а если будут входные параметры?")
    fileprivate func buildRequest<T: APIRequest>(from route: T) throws -> URLRequest {
        
//        var request = URLRequest(url: URL(string: route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
//        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        var request = URLRequest(url: URL(string: baseUrl + route.path)!)
        
        request.httpMethod = route.HTTPMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

