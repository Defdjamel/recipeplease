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
//       Rating
        if let rating = dict.object(forKey: "rating") as? Int {
            recipe.rating = NSNumber.init(value: rating)
        }
//        Time
        if let totalTimeInSeconds = dict.object(forKey: "totalTimeInSeconds") as? Int {
            recipe.totalTimeInSeconds = NSDecimalNumber.init(value: totalTimeInSeconds)
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
