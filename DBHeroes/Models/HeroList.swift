//
//  HeroList.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 27/9/23.
//

import Foundation

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}


