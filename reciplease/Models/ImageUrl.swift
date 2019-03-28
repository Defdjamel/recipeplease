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
            let context = AppDelegate.viewContext
            let request: NSFetchRequest<ImageUrl> = ImageUrl.fetchRequest()
            request.predicate = NSPredicate(format: "url == %@ " , item)
            if let ImageUrls = try? context.fetch(request), ImageUrls.count > 0 {
           
            }else{
                let imageUrl = ImageUrl(context: AppDelegate.viewContext)
                imageUrl.url = item
                imageUrl.recipe = recipe
                
                try? AppDelegate.viewContext.save()
            }
            
        }
        
    }

}
