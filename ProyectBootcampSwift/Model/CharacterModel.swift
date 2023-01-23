//
//  CharacterModel.swift
//  ProyectBootcampSwift
//
//  Created by Mario Merida on 20/01/2023.
//

import Foundation

struct ApiResponse : Decodable {
    var info: PageInfo
    var results: [CharacterModel]
}

struct PageInfo : Decodable {
    let count: Int
    let pages : Int
    let next : String?
    let prev : String?
}

struct CharacterModel : Decodable {
    let id : Int
    let name : String
    let status : String
    let species: String
    let type : String
    let gender : String
    let image : String
    let episode : [String]
}
