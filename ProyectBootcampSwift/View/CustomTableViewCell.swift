//
//  CustomTableViewCell.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 23/01/2023.
//

import UIKit

protocol CustomTableViewCellDelegate : AnyObject {
    func didTapButton (with characterToShow : CharacterModel? )
}

class CustomTableViewCell: UITableViewCell {
    
    var delegate : CustomTableViewCellDelegate?
    var characterToShow :CharacterModel?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button:UIButton!
    
    @IBAction func didTapButton () {
        delegate?.didTapButton(with: characterToShow ?? nil)
    }
}
