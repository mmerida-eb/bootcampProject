//
//  ViewController.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 18/01/2023.
//

import UIKit

class MainView: UIViewController{
    
    @IBOutlet weak var characterTable: UITableView!
    var newConnection = CharacterConectionManager()
    var pageResponse : ApiResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newConnection.delegate = self
        characterTable.dataSource = self
        newConnection.getCharacterList()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func previusButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
}

extension MainView : UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
}


extension MainView : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = pageResponse?.results[indexPath.row]
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier:"character", for: indexPath) as! CustomTableViewCell
        tableViewCell.iconImageView.imageToLoad(urlString: characterCell?.image ?? "")
        tableViewCell.label.text = characterCell?.name
        return tableViewCell
    }
}

extension MainView : CharacterListManagerDelegate  {
    func didUpdateCharacterList(_ characterConectionManager: CharacterConectionManager, _ characterResponse: ApiResponse) {
        self.pageResponse = characterResponse
    }
    
    func didFailWithError(error: Error) {
        print("adios")
        print(error)
    }
}

extension UIImageView {
    func imageToLoad(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
