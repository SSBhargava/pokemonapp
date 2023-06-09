//
//  ViewController.swift
//  tableTrail
//
//  Created by Sai Bhargava Reddy Shada on 13/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokemonTable: UITableView!
    let dataManager = PokemonModel()
    var pokeImages = NSCache<NSString,UIImage>()
    var resultArray:[DataResult]? = [DataResult](){
        didSet {
            DispatchQueue.main.async {
                self.pokemonTable.reloadData()
            }
        }
    }
    var image: UIImage? = UIImage() {
        didSet {
            DispatchQueue.main.async {
                self.pokemonTable.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "POKEMONs"
        pokemonTable.dataSource = self
        pokemonTable.delegate = self
        dataManager.fetchPokeList { response in
            if let result = response{
                self.resultArray = result.results
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = resultArray?.count else {
            return 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var content  = cell.defaultContentConfiguration()
        if let result = resultArray, let pokename = result[indexPath.row].name {
            content.text = pokename.capitalized
            content.secondaryText = result[indexPath.row].url
            content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            if let cached = pokeImages.object(forKey: NSString(string: pokename)) {
                content.image = cached
                cell.contentConfiguration = content
            } else {
                dataManager.fetchPokeImage(pokeNo: indexPath.row) {res in
                    content.image = res
                    DispatchQueue.main.async {
                        self.pokeImages.setObject(res, forKey: NSString(string: pokename))
                        cell.contentConfiguration = content
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let detailVC =  storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        if let content = cell?.contentView.subviews[0] as? UIImageView {
            detailVC.image = content.image
        }
        detailVC.title = resultArray?[indexPath.row].name?.capitalized
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

