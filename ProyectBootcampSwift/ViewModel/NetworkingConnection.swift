//
//  NetworkingConnection.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 20/01/2023.
//

import Foundation

protocol CharacterListManagerDelegate {
    func didUpdateCharacterList(_ characterConectionManager:CharacterConectionManager, _ characterResponse: ApiResponse, _ name:String?)
    func didFailWithError(error:Error)
}


struct CharacterConectionManager {
    let characterURL = "https://rickandmortyapi.com/api/character"
    
    var delegate: CharacterListManagerDelegate?
    
    
    func getCharacterList(_ name: String?){
        var urlWithParameters = "https://rickandmortyapi.com/api/character"
        if name != ""{
            urlWithParameters += "/?name=\(name!.replacingOccurrences(of: " ", with: "%"))"
        }
        print(urlWithParameters)
        if let url = URL(string: urlWithParameters) {
            //create URL session
            let session = URLSession(configuration: .default)
            //create a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let CharactersPage = self.parseJSONResponse(characterData: safeData){
                        delegate?.didUpdateCharacterList(self, CharactersPage, name)
                    }
                }
            }
            //start the task
            task.resume()
        }
    }
    
    func getCharacterPage(nextPageurl :String) {
        if let url = URL(string: nextPageurl) {
            //create URL session
            let session = URLSession(configuration: .default)
            //create a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let CharactersPage = self.parseJSONResponse(characterData: safeData){
                        delegate?.didUpdateCharacterList(self, CharactersPage,"")
                    }
                }
            }
            //start the task
            task.resume()
        }
        
    }
    
    func parseJSONResponse(characterData: Data) -> ApiResponse?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ApiResponse.self, from: characterData)
            return decodedData
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
