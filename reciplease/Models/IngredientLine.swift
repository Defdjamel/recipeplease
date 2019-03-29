//
//  IngredientLine.swift
//  reciplease
//
//  Created by james on 28/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import CoreData
class IngredientLine: NSManagedObject {
    static func saveIngredientLines(_ items: [String], _ recipe : Recipe ) {
        for item in items {
            //check Duplicate
            let context = AppDelegate.viewContext
            let request: NSFetchRequest<IngredientLine> = IngredientLine.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@ and recipe.id == %@ " , item, recipe.id!)
            if let ingredientLines = try? context.fetch(request), ingredientLines.count > 0  {//already exist
            }
            else {
                let ingredientLine = IngredientLine(context: AppDelegate.viewContext)
                ingredientLine.name = item
                ingredientLine.recipe = recipe
                try? AppDelegate.viewContext.save()
            }
        }
    }
}
