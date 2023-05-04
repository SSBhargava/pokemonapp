//
//  DetailsViewController.swift
//  tableTrail
//
//  Created by Sai Bhargava Reddy Shada on 13/04/23.
//

import UIKit


class DetailsViewController: UIViewController {

    
    @IBOutlet weak var pokeImage: UIImageView!
    var image: UIImage?
    override func viewWillAppear(_ animated: Bool) {
        pokeImage.image = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeImage.image
    }
}
