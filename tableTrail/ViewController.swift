//
//  ViewController.swift
//  tableTrail
//
//  Created by Sai Bhargava Reddy Shada on 13/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokemonTable: UITableView!
    
    var viewmodel: PokeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = PokeViewModel()
//        viewmodel = goutmVM()
        
        viewmodel.fetchPokemon()
        viewmodel.reloadTableView! = {
            [weak self] in
            DispatchQueue.main.async {
                self?.pokemonTable.reloadData()
            }
        }
        title = "POKEMONs"
        pokemonTable.dataSource = self
        pokemonTable.delegate = self
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewmodel.resultArray?.count else {
            return 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var content  = cell.defaultContentConfiguration()
        if let result = viewmodel.resultArray {
            content.text = result[indexPath.row].name?.capitalized
            content.secondaryText = result[indexPath.row].url
            content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            content.image = viewmodel.fetchPokeImages(pokeNo: indexPath.row)
                DispatchQueue.main.async {
                    cell.contentConfiguration = content
                }
//            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let detailVC =  storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        if let content = cell?.contentView.subviews[0] as? UIImageView {
            detailVC.image = content.image
        }
//        detailVC.title = resultArray?[indexPath.row].name?.capitalized
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

