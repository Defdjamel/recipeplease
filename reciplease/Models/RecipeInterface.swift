//
//  RecipeInterface.swift
//  reciplease
//
//  Created by james on 27/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

/**
 RecipeInterface is an interface of Recipe
 Used to populate View and Cell.
 */
protocol RecipeInterface {
     var title: String? { get }
     var subtitle: String? { get }
     var imageUrl: String? { get }
     var rate: String? { get }
     var time: String? { get }
}
