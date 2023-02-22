//
//  Coordinator.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 22/02/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
