//
//  Presenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

#warning("надо закрыть все протоколами")
#warning("Лучше сделать какой-то класс который будет работаь с реалмом, чтобы внутри пресентера каждый раз не инитить реалм")
final class Presenter {
    weak var view: ViewController?
    
    let realm = try! Realm()
    
    func getCharacters() {
        NetworkManager.router.request(CharactersAPI()) { result in
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.view?.showModels(characters)
                }
            case .failure(_):
                print("something goes wrong")
            }
        }
    }

    
    func saveModel(from model: CharacterModel) {
        let modelForSave = CharacterModelRealm(id: model.id)
        
        if realm.object(ofType: CharacterModelRealm.self, forPrimaryKey: model.id) != nil { return }
        
        modelForSave.name = model.name
        modelForSave.status = model.status
        modelForSave.species = model.species
        modelForSave.type = model.type
        modelForSave.gender = model.gender
        modelForSave.originName = model.origin.name
        modelForSave.imageUrl = model.imageUrl
        modelForSave.characterUrl = model.characterUrl
        
        try! realm.write {
            realm.add(modelForSave)
        }
    }
    //непонятное название функции
    func loadCharactersRealm() -> [CharacterModelRealm] {
        let characters = realm.objects(CharacterModelRealm.self)
        var modelsRealm: [CharacterModelRealm] = []
        
        characters.forEach({ character in
            modelsRealm.append(character)
        })
        
        view?.reloadData()
        
        print(characters.count)
        
        return modelsRealm
    }
}
