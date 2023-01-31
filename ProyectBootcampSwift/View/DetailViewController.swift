//
//  DetailViewController.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 31/01/2023.
//

import UIKit

class DetailViewController: UIViewController{
    
    var characterToShow : CharacterModel?
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCharacter.text = characterToShow?.name
        imageCharacter.imageToLoad(urlString: characterToShow?.image ?? "")
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
