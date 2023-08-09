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
    func fetchPokeImages(pokeNo: Int, imageData:@escaping ((UIImage) -> Void) )
    
}

class PokeViewModel: PokeViewModelProtocol {
    var reloadTableView: (() -> Void)?
    
    
    var resultArray:[DataResult]? = [DataResult](){
        didSet {
            print("inside result vm")
            reloadTableView?()
        }
    }

    var pokeImages = NSCache<NSString,UIImage>()
    
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
    
    func fetchPokeImages(pokeNo: Int, imageData: @escaping ((UIImage) -> Void) ) {
        model = PokemonModel()
        self.model.fetchPokeImage(pokeNo: pokeNo) { Image in
            imageData(Image)
        }
    }
    
}
