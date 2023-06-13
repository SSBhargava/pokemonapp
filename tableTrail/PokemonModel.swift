//
//  pokemonModel.swift
//  tableTrail
//
//  Created by Sai Bhargava Reddy Shada on 24/04/23.
//

import Foundation
import UIKit

// MARK: - Pokemon
struct Pokemon: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [DataResult]?
}

// MARK: - Result
struct DataResult: Codable {
    var name: String?
    var url: String?
}

protocol pokeModelProtocol {
    func fetchPokeList(completionHandler: @escaping (Pokemon?)-> Void)
    func fetchPokeImage(pokeNo:Int ,compHan: @escaping (UIImage)->Void )
}

class PokemonModel: pokeModelProtocol {
    let urlPoke = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1000&offset=0")
    var pokeImage = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
    var pokeNo: Int? = 1 {
        didSet {
            pokeImage = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokeNo ?? 1).png")
        }
    }
    
    func fetchPokeList(completionHandler: @escaping (Pokemon?)-> Void) {
        let request = URLRequest(url: urlPoke!)
       // request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           // print("ggg", data, response, error)
            if let res = data {
                do{
                    let serial = try JSONDecoder().decode(Pokemon.self, from: res)
                    completionHandler(serial)
                } catch let error{
                    print("Decode error :",error)
                }
            }else{
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    func fetchPokeImage(pokeNo:Int ,compHan: @escaping (UIImage)->Void ) {
        self.pokeNo = pokeNo + 1
        let request = URLRequest(url: pokeImage!)
        
        let task = URLSession.shared.dataTask(with: request)
        { dat, resp, err in
            DispatchQueue.main.async {
                if let img = dat {
   
                    //                print("this image \(pokeNo)",UIImage(data: img))
                    compHan(UIImage(data: img) ?? UIImage())
                }
            }
        }
        task.resume()
    }
    
}

