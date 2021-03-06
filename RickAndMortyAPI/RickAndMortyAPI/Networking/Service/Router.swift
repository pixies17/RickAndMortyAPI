//
//  Router.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

final class Router<EndPoint: APIRequest>: NetworkRouter {
    private var task: URLSessionTask?
    let decoder = JSONDecoder()
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func send<T: APIRequest>(_ request: T, completion: @escaping NetworkRouterCompletion<T.Response>) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noInternet))
                    return
                }
                    let result = NetworkManager.handleNetworkResponse(response)
                    
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(.incorrectData))
                            return
                        }
                        do {
                            let apiResponse = try self.decoder.decode(T.Response.self, from: responseData)
                            completion(.success(apiResponse))
                        } catch {
                            completion(.failure(.decoding))
                        }
                    case .failure:
                        completion(.failure(.serverError))
                    }
            })
        } catch {
            completion(.failure(.encoding))
        }
        task?.resume()
    }
    
    fileprivate func buildRequest<T: APIRequest>(from route: T) throws -> URLRequest {
        var urlComponets = URLComponents()
        urlComponets.setQueryItems(with: route.parameters)
        
        var request = URLRequest(url: URL(string: baseUrl + route.path + (urlComponets.url?.absoluteString ?? ""))!)
        
        request.httpMethod = route.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("\(request)")
        return request
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    }
}
