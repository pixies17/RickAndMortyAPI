//
//  CharactersListPresenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

final class CharactersListPresenter {
    weak var view: CharactersListViewInput?
    var router = Router<CharactersRequest>()
        
    func getCharacters() {
        router.send(CharactersRequest(parameters: ["page": 13])) { result in
            switch result {
            case .success(let charactersList):
                DispatchQueue.main.async {
                    self.view?.showModels(charactersList.results)
                }
            case .failure(_):
                print("something goes wrong")
            }
        }
    }

    
    func createModelRealm(for model: Character) {
        let realm = RealmService.shared.realm

        #warning("создать метод проверки существования сущности по id")
        guard realm.object(ofType: Character.self, forPrimaryKey: model.id) == nil else { return }

        RealmService.shared.save(model)
    }
    
    func charactersListFromRealm() -> [Character] {
        let characters = RealmService.shared.load(Character.self)
        
        view?.reloadData()
        
        print(characters.count)
        
        return characters
    }
}
