//
//  Assembly.swift
//  RickAndMortyAPI
//
//  Created by Egor Kosilov on 19.10.2020.
//

import Foundation

#warning("лучше поработать с неймингами, не просто вью контроллер и тп, а CharactersListViewController и тп")
final class Assembly {
    
    static func createCharacterModule() -> ViewController {
        let vc = ViewController()
        
        let output = Presenter()
        output.view = vc
        
        vc.output = output
        
        return vc
    }
}
