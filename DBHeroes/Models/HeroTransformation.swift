//
//  HeroTransformation.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 28/9/23.
//

import Foundation

// MARK: - Transformation
struct Transformation: Decodable {
    let id: String
    let name: String
    let photo: URL
    let description: String
}
