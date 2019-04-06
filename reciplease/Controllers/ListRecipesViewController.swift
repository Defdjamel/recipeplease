//
//  ListRecipesViewController.swift
//  reciplease
//
//  Created by james on 25/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import CoreData
private let cellIdentifier = "ListRecipeTableViewCell"
class ListRecipesViewController: UIViewController {
    var ingredients : [String] = []
  
   private var recipes : [Recipe] = []
   private var currentPage : Int = 0
   private var isLoading  = false
   private var hasMoreAvailable = true

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        searchRecipes()//init first call with ingredients parameters
    }
    private func showMoreRecipes(){
        searchRecipes()
    }
    // MARK: - Setup
    private func setup(){
        self.tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)//register Cell
    }
    
    // MARK: - Data
    func searchRecipes(){
        if isLoading { //cancel request if loading in progress
            return
        }
        
        showActivity()
        isLoading = true
        NetworkManager.sharedInstance.searchRecipes(ingredients,startPage: currentPage, success: { (recipes) in
            self.hasMoreAvailable = recipes.count >= recipeMaxRequest ? true : false
            self.recipes.append(contentsOf: recipes)
            self.tableView.reloadData()
            self.hideActivity()
            if self.recipes.isEmpty {
                self.showErrorNoRecipe()
            }
            self.isLoading = false
        }) {//failed!
           self.hideActivity()
           self.showErrorNoRecipe()
           self.isLoading = false
        }
    }
    
     // MARK: - ViewLifeCycle
    private func showActivity(){
        activtyIndicator.startAnimating()
        activtyIndicator.isHidden = false
    }
    private func hideActivity(){
        activtyIndicator.startAnimating()
        activtyIndicator.isHidden = true
    }
    private func showErrorNoRecipe(){
        self.showErrorMessage("No recipe found!") { (action) in
             self.navigationController?.popViewController(animated: true)
        }
       
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination =  segue.destination as? DetailsRecipeTableViewController, let row = tableView.indexPathForSelectedRow?.row {
            let recipeSelected = recipes[row]
            destination.curentRecipe = recipeSelected
            print("recipe Selected : \(recipeSelected.name!)")
        }
    }
    

}
// MARK: - UITableViewDelegate
extension ListRecipesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "List_Details", sender: self)
    }
    
}
// MARK: - UITableViewDataSource
extension ListRecipesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! ListRecipeTableViewCell
        cell.setRecipe(recipes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == recipes.count {
            //Show more recipe if has available
            currentPage += 1
            if hasMoreAvailable{
               showMoreRecipes()
            }
        }
    }
}

