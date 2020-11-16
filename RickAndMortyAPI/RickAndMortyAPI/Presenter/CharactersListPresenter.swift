//
//  CharactersListPresenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation
import RealmSwift

final class CharactersListPresenter {
    weak var view: CharactersListViewInput!
    var router = Router<CharactersRequest>()
    
    var charactersOnPage = 20
    var currentPage: Int {
        return view.models.count / charactersOnPage
    }
    var maxCount: Int?
        
    func getCharacters() {
        
        router.send(CharactersRequest(parameters: ["page": (currentPage + 1)])) { result in
            switch result {
            case .success(let charactersList):
                DispatchQueue.main.async {
                    let cachedCount = self.view.models.count
                    self.updateMaxCount(with: charactersList.info.count)
                    self.view.models.append(contentsOf: charactersList.results)
                    self.view.append(charactersList.results, startIndex: cachedCount)
                    print(self.currentPage)
                    print("\(charactersList.results.count)")
                }
            case .failure(_):
                print("something goes wrong")
            }
        }
    }

    
    func createModelRealm(for model: Character) {
        guard RealmService.shared.isEntityExist(in: Character.self, id: model.id) == false else { return }

        RealmService.shared.save(model)
    }
    
    func charactersListFromRealm() -> [Character] {
        let characters = RealmService.shared.load(Character.self)
        
        view.reloadData()
        
        print(characters.count)
        
        return characters
    }
    
    func updateMaxCount(with count: Int) {
        maxCount = count
        print("maxCount: \(String(describing: maxCount))")
    }
}
