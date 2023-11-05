//
//  LocalDataModel.swift
//  DBHeroes
//
//  Created by Miguel Nantón Díaz on 28/9/23.
//

import Foundation

struct LocalDataModel {
    
    private static let key = "SuperHeroesToken"
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: key)
    }
    
    static func saveToken (token: String){
        userDefaults.setValue(token, forKey: key)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: key)
    }
}
