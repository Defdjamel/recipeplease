//
//  Ingredient.swift
//  reciplease
//
//  Created by james on 27/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import CoreData

class Ingredient: NSManagedObject {
    static func saveIngredients(_ items: [String], _ recipe : Recipe ) {
        for item in items {
            //check Duplicate
            if let list = recipe.ingredients , list.contains(item) {
            }else{
                let ingredient = Ingredient(context: AppDelegate.viewContext)
                ingredient.name = item
                ingredient.addToRecipes(recipe)
                
                try? AppDelegate.viewContext.save()
            }
            
        }
        
    }

}
