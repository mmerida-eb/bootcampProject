//
//  SearchFilter.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 02/02/2023.
//

import UIKit


class SearchFilterController : UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        
    }
    
    
    @IBOutlet weak var genderSelected: UISegmentedControl!
    @IBOutlet weak var statusSelected: UISegmentedControl!
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let genderSelected = genderSelected.titleForSegment(at: genderSelected.selectedSegmentIndex)
        let statusSelected = statusSelected.titleForSegment(at: statusSelected.selectedSegmentIndex)
        print(genderSelected)
        print(statusSelected)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
