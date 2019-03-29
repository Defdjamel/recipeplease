//
//  recipleaseTests.swift
//  recipleaseTests
//
//  Created by james on 24/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import XCTest
import CoreData
@testable import reciplease
class recipleaseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchRecipeWithIngredients(){
       let promise = expectation(description: "Status code: 200")
        reciplease.NetworkManager.sharedInstance.searchRecipes(["lemon"], startPage: 0, success: { (recipes) in
            if  recipes.count == 20 {
                 promise.fulfill()
            }
            else {
               XCTFail("Status code: fail request search")
            }
           
        }) {
             XCTFail("Status code: fail request search")
        }
          waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testGetDetailsRecipe(){
        let promise = expectation(description: "Status code: 200")
        //get 1st recipe in database
        guard let recipe = reciplease.Recipe.all.first else {
            return
        }
        //Request details information
        reciplease.NetworkManager.sharedInstance.detailsRecipe( recipe , success: { (recipe) in
             promise.fulfill()
        }) {
            XCTFail("Status code: fail request GetDetailsRecipe")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddRemoveFavorite(){
        //get recipe favorite count
        let favCountBefore = reciplease.Recipe.favorites.count
        if favCountBefore == 0 {
            return
        }
        //add favorite to 1st recipe
        guard let recipe = reciplease.Recipe.all.first else {
            return
        }
        recipe.setFavorite()
        let favCountAfter = favCountBefore + (recipe.isFavorite ? 1 : -1)
        
        //check new favorite count
        XCTAssertEqual(reciplease.Recipe.favorites.count, favCountAfter , "StestAddFavorite is wrong")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
