//
//  LocalDataModelTest.swift
//  DBHeroesTests
//
//  Created by Miguel Nantón Díaz on 6/11/23.
//

import XCTest
@testable import DBHeroes

final class LocalDataModelTests: XCTestCase {
    
    /*
     override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    */
    
    func testSetGetToken() {
        let token = "tokenTest"
        LocalDataModel.saveToken(token: token)
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertEqual(retrievedToken, token, "El Token guardado tiene que ser igual a tokenTest")
    }
    
    func testDeleteToken() {
        let token = "tokenTest"
        LocalDataModel.saveToken(token: token)
        LocalDataModel.deleteToken()
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "El token tiene que ser nulo")
    }
}
