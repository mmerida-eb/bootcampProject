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
        let vc = UIViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
