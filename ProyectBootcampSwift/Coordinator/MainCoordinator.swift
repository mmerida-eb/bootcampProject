//
//  MainCoordinator.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 22/02/2023.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator{
    var childCoordinator = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainView.instantiate()
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func goToDetails(_ characterToShow:CharacterModel ){
        let vc = DetailViewController.instantiate()
        vc.characterToShow = characterToShow
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    
}
