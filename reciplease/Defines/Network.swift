//
//  Network.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

let hostname = "https://api.yummly.com/v1"
let serviceApi = hostname + "/api/"
let app_key = "2f1e52c26a4c4c1abf8db3603d7768b6"
let app_id = "2ae70267"
let sizeImage = "400"


struct Api {
    static let search_recipes = serviceApi + "recipes"
    static let details_recipe = serviceApi + "recipe"
}
