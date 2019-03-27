//
//  ImageUrl.swift
//  reciplease
//
//  Created by james on 27/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import CoreData
class ImageUrl: NSManagedObject {
    static func saveImageurls(_ items: [String], _ recipe : Recipe ) {
        for item in items {
            //check Duplicate
            if let list = recipe.imageUrls , list.contains(item) {
            }else{
                let imageUrl = ImageUrl(context: AppDelegate.viewContext)
                imageUrl.url = item
                imageUrl.recipe = recipe
                
                try? AppDelegate.viewContext.save()
            }
            
        }
        
    }

}
