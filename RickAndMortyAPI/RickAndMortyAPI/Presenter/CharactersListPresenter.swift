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
    
    var charactersOnPage = 20
    var currentPage: Int {
        return (view?.models.count ?? 0) / charactersOnPage
    }
    var maxCount: Int?
    var isLoadFromRealm = false

        
    func getCharacters() {
        guard let view = view, !isLoadFromRealm else { return }
        let cachedCount = view.models.count
        
        router.send(CharactersRequest(parameters: ["page": (currentPage + 1)])) { result in
            switch result {
            case .success(let charactersList):
                DispatchQueue.main.async {
                    self.updateMaxCount(with: charactersList.info.count)
                    view.models.append(contentsOf: charactersList.results)
                    view.append(charactersList.results, startIndex: cachedCount)
                    print(self.currentPage)
                    print("\(charactersList.results.count)")
                }
            case .failure(_):
                print("something goes wrong")
                DispatchQueue.main.async {
                    self.charactersListFromRealm()
                }
            }
        }
    }

    
    func createModelRealm(for model: Character) {
        guard RealmService.shared.isEntityExist(Character.self, id: model.id) == false else { return }

        RealmService.shared.save(model)
    }
    
    func charactersListFromRealm() {
        view?.models = []
        
        let characters = RealmService.shared.load(Character.self)
        
        view?.models = characters
        
        view?.reloadData()
        view?.scrollToTop()
        
        isLoadFromRealm = true
        
        print(characters.count)
    }
    
    func updateMaxCount(with count: Int) {
        maxCount = count
        print("maxCount: \(String(describing: maxCount))")
    }
}
