//
//  CharactersListPresenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

final class CharactersListPresenter {
    weak var view: CharacterListViewInput?
    var router = Router<CharactersRequest>()
        
    func getCharacters() {
        router.send(CharactersRequest(parameters: ["page": 14])) { result in
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

    
    func createModelRealm(for model: CharacterModel) {
        let realm = RealmService.shared.realm
        
        let modelForSave = CharacterModel(id: model.id)
        #warning("такие кейсы лучше закрывать guardom ")
        if realm.object(ofType: CharacterModel.self, forPrimaryKey: model.id) != nil { return }
        
        modelForSave.name = model.name
        modelForSave.status = model.status
        modelForSave.species = model.species
        modelForSave.type = model.type
        modelForSave.gender = model.gender
        modelForSave.origin?.name = model.origin?.name ?? ""
        modelForSave.imageUrl = model.imageUrl
        modelForSave.characterUrl = model.characterUrl
        
        #warning(" почему сразу нельзя сохранить модель, которая подается на вход?")
        RealmService.shared.save(modelForSave)
    }
    
    func charactersListFromRealm() -> [CharacterModel] {
        let realm = RealmService.shared.realm
        #warning("сделай функцию в менеджере куда подается тип и ты достаешь все элементы этого типа из базы и возвращается сразу массив")
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
