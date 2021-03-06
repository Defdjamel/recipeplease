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
    /** this funtion return an existing object if exist else a new.
     Parameters: id
     */
    static func getRecipe(_ id: String) -> Recipe {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ " , id)
        if let recipesDuplicate = try? context.fetch(request), let recipeDuplicate = recipesDuplicate.first  {
           return recipeDuplicate
        }else{
           let recipe =  Recipe(context: context )
            recipe.id = id
            return recipe
        }
    }
    static func saveRecipe(_ dict: NSDictionary) -> Recipe{
        let context = AppDelegate.viewContext
        guard let id = dict.object(forKey: "id") as? String else{
            return Recipe(context: context )
        }
        let recipe = self.getRecipe(id)
//       Rating
        if let rating = dict.object(forKey: "rating") as? Int {
            recipe.rating = NSNumber.init(value: rating)
        }
//        Time
        if let totalTimeInSeconds = dict.object(forKey: "totalTimeInSeconds") as? Int {
            recipe.totalTimeInSeconds = NSDecimalNumber.init(value: totalTimeInSeconds)
        }
//        Name
        if let name = dict.object(forKey: "recipeName") as? String {
            recipe.name = name
        }
//        sourceRecipeUrl
        if let source = dict.object(forKey: "source") as? NSDictionary, let sourceUrl = source.object(forKey: "sourceRecipeUrl") as? String {
            recipe.instrucionsUrl = sourceUrl
        }
    
        try? context.save()
        
        //add ingredient
        if let ingredients = dict.object(forKey: "ingredients") as? [String] {
            Ingredient.saveIngredients(ingredients, recipe)
        }
        //add ingredientLine
        if let ingredientLines = dict.object(forKey: "ingredientLines") as? [String] {
            IngredientLine.saveIngredientLines(ingredientLines, recipe)
        }
    
        //add images
        if let imageUrls = dict.object(forKey: "smallImageUrls") as? [String] {
            ImageUrl.saveImageurls(imageUrls, recipe)
        }
        return recipe
    }
    
    func setFavorite(){
        self.favorite = !self.favorite
        try? AppDelegate.viewContext.save()
    }
    
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipes
    }
    
    static var favorites: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "favorite == true ")
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipes
    }
    
    
}

/**
 RecipeInterface is an interface of Recipe
 Used to populate View and Cell.
 */
extension Recipe : RecipeInterface {
    var title: String? {
        return self.name
    }
    var subtitle: String? {//liste ingredient
        var content  = ""
        if let ingredients =  ingredients {
            for ingredient in ingredients {
                if let ingredient = ingredient as? Ingredient, let name  = ingredient.name{
                    content += "\(name), "
                }
            }
        }
       
        return content
    }
    
    var imageUrl: String? {
        if let imageUrls = imageUrls{
            for imageUrl in imageUrls {
               if let imageUrl = imageUrl as? ImageUrl, var url =  imageUrl.url {
                    //remove s90
                    url  = url.replacingOccurrences(of: "=s90", with: "=s\(sizeImage)")
                    return url
                }
            }
            
        }
        return nil
    }
    
    var rate: String? {
        if let rating = rating {
            return rating.stringValue
        }
        return "-"
    }
    
    var time: String? {
        if let time = totalTimeInSeconds {
            //Convert to Minute
            return time.doubleValue.getMinutesHoursFromSeconds()
        }
        return "-"
    }
    
    var isFavorite: Bool {
            return favorite
    }
    
}
