//
//  Assembly.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 19.10.2020.
//

import Foundation

final class Assembly {
    
    static func createCharacterModule() -> CharactersListViewController {
        let vc = CharactersListViewController()
        
        let output = CharactersListPresenter()
        output.view = vc
        
        vc.output = output
        
        return vc
    }
}
