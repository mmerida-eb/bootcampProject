//
//  CustomTableViewCell.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 23/01/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var characterToShow :CharacterModel?
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
}
