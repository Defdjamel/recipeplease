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
    var recipes : [Recipe] = []
    var currentPage : Int = 0

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activtyIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)//register Cell
        searchRecipes()//init first call with ingredients parameters
    
    }
    
    private func searchRecipes(){
       showActivity()
        NetworkManager.sharedInstance.searchRecipes(ingredients,startPage: currentPage, success: { (recipes) in
            self.recipes = recipes
            self.tableView.reloadData()
            self.hideActivity()
         
            
        }) {//failed!
           self.hideActivity()
        }
    }
    
    private func showActivity(){
        activtyIndicator.startAnimating()
        activtyIndicator.isHidden = false
    }
    private func hideActivity(){
        activtyIndicator.startAnimating()
        activtyIndicator.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UITableViewDelegate
extension ListRecipesViewController: UITableViewDelegate{
    
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
}

