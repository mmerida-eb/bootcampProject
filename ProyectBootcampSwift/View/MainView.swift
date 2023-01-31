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
    var isCalling = true

    override func viewDidLoad() {
        super.viewDidLoad()
        characterTable.delegate = self
        newConnection.delegate = self
        characterTable.dataSource = self
        newConnection.getCharacterList()
        // Do any additional setup after loading the view.
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
        tableViewCell.delegate = self
        tableViewCell.characterToShow = characterCell
        tableViewCell.iconImageView.imageToLoad(urlString: characterCell?.image ?? "")
        tableViewCell.label.text = characterCell?.name
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension MainView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (characterTable.contentSize.height - 100 - scrollView.frame.size.height) && isCalling{
            isCalling = false
            newConnection.getCharacterPage(nextPageurl: pageResponse?.info.next ?? "")
        }
    }
}


extension MainView : CharacterListManagerDelegate  {
    func didUpdateCharacterList(_ characterConectionManager: CharacterConectionManager, _ characterResponse: ApiResponse) {
        if self.pageResponse?.results != nil {
            self.pageResponse?.info = characterResponse.info
            self.pageResponse?.results.append(contentsOf: characterResponse.results)
            DispatchQueue.main.async {
                self.characterTable.reloadData()
            }
            isCalling = true
        }else {
            self.pageResponse = characterResponse
        }
    }
    
    func didFailWithError(error: Error) {
        print("adios")
        print(error)
    }
}

extension MainView : CustomTableViewCellDelegate{
    func didTapButton(with characterToShow: CharacterModel?) {
        print(characterToShow!)
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
