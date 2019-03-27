//
//  Recipe.swift
//  reciplease
//
//  Created by james on 25/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import CoreData

class Recipe: NSManagedObject {
    
    static func saveRecipe(_ dict: NSDictionary) -> Recipe{
        var recipe = Recipe(context: AppDelegate.viewContext)
        if let id = dict.object(forKey: "id") as? String {
            recipe.id = id
            //avoid duplicate
            //check if recipe with same id exist and update it.
            let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            if let recipesDuplicate = try? AppDelegate.viewContext.fetch(request), let recipeDuplicate = recipesDuplicate.first {
               recipe = recipeDuplicate
            }
        }
       
        
        if let name = dict.object(forKey: "recipeName") as? String {
            recipe.name = name
        }
        try? AppDelegate.viewContext.save()
        
        //add ingredient
        
        if let ingredients = dict.object(forKey: "ingredients") as? [String] {
            Ingredient.saveIngredients(ingredients, recipe)
        }
        
        
        //add images
        
        return recipe
        
    }
    
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipes
    }
}

extension Recipe : RecipeInterface {
    var title: String? {
        return self.name
    }
    var subtitle: String? {//liste ingredient
        var content  = ""
        if let ingredients =  ingredients {
            for ingredient in ingredients {
                if let ingredient = ingredient as? Ingredient, let name  = ingredient.name{
                    content += "\(name) "
                }
            }
        }
       
        return content
    }
    
}
