//
//  Presenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

final class Presenter {
    weak var view: ViewController?
    
    let realm = try! Realm()
    
    func getCharacters() {
        NetworkManager.getNewCharacters(requestState: .forPage(page: 1)) { models, error in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                guard let models = models else { return }
                
                self.view?.showModels(models)
            }
        }
    }
    
    func saveModel(from model: CharacterModel) {
        let modelForSave = CharacterModelRealm()
        
        modelForSave.name = model.name
        modelForSave.id = model.id
        modelForSave.status = model.status
        modelForSave.species = model.species
        modelForSave.type = model.type
        modelForSave.gender = model.gender
//        modelForSave.origin = model.origin
        modelForSave.imageUrl = model.imageUrl
        modelForSave.characterUrl = model.characterUrl
        
        try! realm.write {
            realm.add(modelForSave)
        }
    }
//    
//    func loadCharactersRealm(from model: CharacterModelRealm) {
//        let characters = realm.objects(model)
//    }
}
