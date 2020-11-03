//
//  CharactersListPresenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

#warning("Лучше сделать какой-то класс который будет работаь с реалмом, чтобы внутри пресентера каждый раз не инитить реалм")
final class CharactersListPresenter {
    weak var view: CharacterListViewInput?
    var router = Router<CharactersRequest>()
    
    let realm = try! Realm()
    
    func getCharacters() {
        router.send(CharactersRequest(parameters: ["page": 15])) { result in
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.view?.showModels(characters.results)
                }
            case .failure(_):
                print("something goes wrong")
            }
        }
    }

    
    func saveModel(from model: CharacterModel) {
        let modelForSave = CharacterModel(id: model.id)
        
        if realm.object(ofType: CharacterModel.self, forPrimaryKey: model.id) != nil { return }
        
        modelForSave.name = model.name
        modelForSave.status = model.status
        modelForSave.species = model.species
        modelForSave.type = model.type
        modelForSave.gender = model.gender
        modelForSave.origin?.name = model.origin?.name ?? ""
        modelForSave.imageUrl = model.imageUrl
        modelForSave.characterUrl = model.characterUrl
        
        try! realm.write {
            realm.add(modelForSave)
        }
    }
    
    func loadCharactersFromRealm() -> [CharacterModel] {
        let characters = realm.objects(CharacterModel.self)
        var modelsRealm: [CharacterModel] = []
        
        characters.forEach({ character in
            modelsRealm.append(character)
        })
        
        view?.reloadData()
        
        print(characters.count)
        
        return modelsRealm
    }
}
