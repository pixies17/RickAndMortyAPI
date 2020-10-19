//
//  Presenter.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 14.10.2020.
//

import Foundation

final class Presenter {
    weak var view: ViewController?
    
    func getCharacters() {
        NetworkManager.getNewCharacters(requestState: .forPage(page: 1)) { models, error in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                guard let models = models else { return }
                
                self.view?.showModels(models)
            }
        }
    }
}
