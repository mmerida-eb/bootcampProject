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
    var characterToDetail :CharacterModel?
    var genderSelected :String? = ""
    var statusSelected :String? = ""

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character List"
        characterTable.delegate = self
        newConnection.delegate = self
        characterTable.dataSource = self
        newConnection.getCharacterList("")
        searchTextField.delegate = self
    }
    

    @IBAction func filterButtonPressed(_ sender: UIButton) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilterController") as! SearchFilterController
        
        self.navigationController?.pushViewController(mapViewControllerObj, animated: true)
    }
    
}

extension MainView : UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        let characterName = searchTextField.text
        newConnection.getCharacterList(characterName)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        return false
    }
}


extension MainView : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = pageResponse?.results[indexPath.row]
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier:"character", for: indexPath) as! CustomTableViewCell
        tableViewCell.characterToShow = characterCell
        tableViewCell.iconImageView.imageToLoad(urlString: characterCell?.image ?? "")
        tableViewCell.label.text = characterCell?.name
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        mapViewControllerObj.characterToShow = pageResponse?.results[indexPath.row]
        */
        let storyboard = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        storyboard.characterToShow = pageResponse?.results[indexPath.row]
        self.navigationController?.pushViewController(storyboard, animated: true)
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
    func didUpdateCharacterList(_ characterConectionManager: CharacterConectionManager, _ characterResponse: ApiResponse,_ name:String?) {
        if self.pageResponse?.results != nil {
            self.pageResponse?.info = characterResponse.info
            if name != ""{
                self.pageResponse?.results = characterResponse.results
            } else {
                self.pageResponse?.results.append(contentsOf: characterResponse.results)
            }
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
