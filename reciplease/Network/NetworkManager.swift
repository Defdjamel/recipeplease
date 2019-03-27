//
//  NetworkManager.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import Alamofire
class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
}
//MARK: - REQUESTS
extension NetworkManager {
    private func apiUrl(_ service: String) -> String{
        let service = service + "?_app_id=\(app_id)&_app_key=\(app_key)&maxResult=20"
        return service
    }
    
    func searchRecipes (_ ingredients : Array<String>, startPage : Int, success: @escaping (Array<Recipe>) -> Void, failed: @escaping () -> Void){
        var service = self.apiUrl(Api.search_recipes)
        
        //add start page
        service +=   "&start=\(startPage)"
        
        //add ingredients
        var ingredientsText  = ""
        for ingredient in ingredients{
           ingredientsText +=   "&allowedIngredient[]=" + ingredient
        }
        ingredientsText = ingredientsText.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        service += ingredientsText
        
        print(service)
        Alamofire.request( service, method: .get ,parameters: nil ,encoding: URLEncoding.default).responseJSON { response in

           //we expect to receive a dictionnary containing a Array in matches key else failed
            if  let json = response.result.value  as? NSDictionary, let recipes =  json.object(forKey: "matches") as? Array<NSDictionary> {
                //add recipes to 
                var recipesStored : [Recipe] = []
                for recipe in recipes {
                  let r =   Recipe.saveRecipe(recipe)
                    recipesStored.append(r)
                }
                success(recipesStored)
            }
            else{
                print("request failed")
                
                failed()
            }
            
        }
    }
   
}
