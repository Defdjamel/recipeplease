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
            let context = AppDelegate.viewContext
            let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@ and recipe.id == %@ " , item, recipe.id!)
            if let ingredients = try? context.fetch(request), ingredients.count > 0 {
            }else{
                let ingredient = Ingredient(context: AppDelegate.viewContext)
                ingredient.name = item
                ingredient.recipe = recipe
                try? AppDelegate.viewContext.save()
            }
        }
    }
}
