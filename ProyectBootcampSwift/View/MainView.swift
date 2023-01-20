//
//  ViewController.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 18/01/2023.
//

import UIKit

class MainView: UIViewController {

    @IBOutlet weak var characterTable: UITableView!
    var newConnection = CharacterConectionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newConnection.getCharacterList()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func previusButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
}

extension MainView : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier:"character")
        return tableViewCell!
    }
    
}



