//
//  Router.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

#warning("почему не final?")
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
                            #warning("в таком случае лучше внутри класса роутер инитить декодер")
                            let apiResponse = try JSONDecoder().decode(T.Response.self, from: responseData)
                            completion(.success(apiResponse))
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
    
    fileprivate func buildRequest<T: APIRequest>(from route: T) throws -> URLRequest {
        var urlComponets = URLComponents()
        urlComponets.setQueryItems(with: route.parameters)
        
        var request = URLRequest(url: URL(string: baseUrl + route.path + (urlComponets.url?.absoluteString ?? ""))!)
        
        request.httpMethod = route.HTTPMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Int]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String($0.value)) }
    }
}
