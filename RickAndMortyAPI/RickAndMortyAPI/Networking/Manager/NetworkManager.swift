//
//  NetworkManager.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 16.10.2020.
//

import Foundation

struct NetworkManager {
    static let router = Router<CharactersAPI>()
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        default: return .failure("Something goes wrong")
        }
    }
    #warning("этого не должно быть в NetworkManager")
    #warning("надо создать класс APIRequest, откуда ты будешь все подтягивать ")
    static func getNewCharacters(route: CharactersAPI, completion: @escaping (CharacterList<[CharacterModel]>) -> Void) {
        router.request(route) { characters in
            completion(characters)
        }
//        router.request(requestState) { data, response, error in
//            if error != nil {
//                completion(nil, "please, check your connection.")
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = handleNetworkResponse(response)
//
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, "empty")
//                        return
//                    }
//
//                    do {
////                        let apiiResponse = try JSONSerialization.jsonObject(with: responseData, options: [])
////                        print (apiiResponse)
//                        let apiResponse = try JSONDecoder().decode(CharacterList.self, from: responseData)
//                        completion(apiResponse.results, nil)
//                    } catch {
//                        completion(nil, "boom")
//                    }
//
//                case .failure(let trouble):
//                    completion(nil, trouble)
//                }
//            }
//        }
//    }
}
}
