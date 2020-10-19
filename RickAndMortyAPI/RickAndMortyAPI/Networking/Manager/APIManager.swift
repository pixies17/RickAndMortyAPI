//
//  APIManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

//import Foundation
//
//typealias JSONTask = URLSessionDataTask
//typealias JSONComletionHandler = ([String: Any]?, URLResponse?, Error?) -> Void
//
//public enum APIResult<T> {
//    case success(T)
//    case failure(Error)
//}
//
//protocol APIManager {
//    var sessionConfiguration: URLSessionConfiguration { get }
//    var session: URLSession { get }
//    
//    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONComletionHandler) -> JSONTask
//    func fetch<T: Decodable>(request: URLRequest, parse: @escaping ([String: Any]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
//}
//
//extension APIManager {
//    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONComletionHandler) -> JSONTask {
//        
//        let dataTask = session.dataTask(with: request) { data, response, error in
//            guard let HTTPResponse = response as? HTTPURLResponse else {
//                let error = NSError()
//                
//                completionHandler(nil, nil, error)
//                return
//            }
//            
//            if data == nil {
//                completionHandler(nil, HTTPResponse, error)
//            } else {
//                switch HTTPResponse.statusCode {
//                case 200:
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                        completionHandler(json, HTTPResponse, nil)
//                    } catch let error as NSError {
//                        completionHandler(nil, HTTPResponse, error)
//                    }
//                default: print("We have got response status \(HTTPResponse.statusCode)")
//                }
//            }
//        }
//        return dataTask
//    }
//    
//    func fetch<T: Decodable>(request: URLRequest, parse: @escaping ([String: Any]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
//        let dataTask = JSONTaskWith(request: request) { json, response, error in
//            guard let json = json else {
//                if let error = error {
//                    completionHandler(.failure(error))
//                }
//                return
//            }
//            
//            if let value = parse(json) {
//                completionHandler(.success(value))
//            } else {
//                let error = NSError()
//                completionHandler(.failure(error))
//            }
//        }
//        dataTask.resume()
//    }
//}
