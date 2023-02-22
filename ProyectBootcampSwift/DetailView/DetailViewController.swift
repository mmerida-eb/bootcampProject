//
//  DetailViewController.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 31/01/2023.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded{
    
    var characterToShow : CharacterModel?
    
    @IBOutlet weak var typeCharacter: UILabel!
    @IBOutlet weak var genderCharacter: UILabel!
    @IBOutlet weak var specieCharacter: UILabel!
    @IBOutlet weak var statusCharacter: UILabel!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeCharacter?.text = characterToShow?.type
        genderCharacter?.text = characterToShow?.gender
        specieCharacter?.text = characterToShow?.species
        statusCharacter?.text = characterToShow?.status
        nameCharacter?.text = characterToShow?.name
        imageCharacter?.imageToLoad(urlString: characterToShow?.image ?? "")
    }    
}
