//
//  pokeViewModel.swift
//  tableTrail
//
//  Created by Gouthami Racharla on 09/06/23.
//

import UIKit
import Foundation

protocol PokeViewModelProtocol {
    var resultArray:[DataResult]? { get }
    var reloadTableView: (() -> Void)? {  get set }
    func fetchPokemon()
    func fetchPokeImages(pokeNo: Int) -> UIImage
    
}

class PokeViewModel: PokeViewModelProtocol {
    var reloadTableView: (() -> Void)?
    
    
    var resultArray:[DataResult]? = [DataResult](){
        didSet {
            reloadTableView?()
        }
    }
    
    var model: pokeModelProtocol!
    
    let dataManager = PokemonModel()
    
    func fetchPokemon() {
        model = PokemonModel()
        DispatchQueue.main.async {
            self.model.fetchPokeList {
                response in
                if let result = response{
                    self.resultArray = result.results
                }
            }
        }
    }
    
    func fetchPokeImages(pokeNo: Int) -> UIImage {
        model = PokemonModel()
        var image = UIImage()
        self.model.fetchPokeImage(pokeNo: pokeNo) { Image in
            image = Image
        }
        print(image)
        
            return image
        
    }
    
}



class goutmVM: PokeViewModelProtocol {
    var reloadTableView: (() -> Void)?
    
    func fetchPokeImages(pokeNo: Int) -> UIImage {
        return UIImage()
    }
    
    var resultArray: [DataResult]?
    
    func fetchPokemon() {
        // print("API poke is called")
        resultArray?.append(DataResult(name: "gautami", url: "hahahahah"))
    }
    
}
