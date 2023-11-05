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

    
    /* Decodificación Personalizada
     
     struct Hero: {
         let id: String
         let name: String
         let description: String
         let photo: URL
         let favorite: Bool
     }

     extension Hero: Decodable {
         enum CodingKeys: String,CodingKey {
             case id
             case name
             case description
             case photo
             case favorite
         }
          
         init(from decoder: Decoder) throws {
             let values = try decoder.container(keyedBy: CodingKeys.self)
             id = try values.decode(String.self, forKey: .id)
             name = try values.decode(String.self, forKey: .name)
             description = try values.decode(String.self, forKey: .description)
             photo = try values.decode(URL.self, forKey: .photo)
             favorite = try values.decode(Bool.self, forKey: .favorite)
         }
     }
    */

