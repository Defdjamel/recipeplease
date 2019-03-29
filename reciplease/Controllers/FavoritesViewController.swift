//
//  FavoritesViewController.swift
//  reciplease
//
//  Created by james on 25/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
private let cellIdentifier = "ListRecipeTableViewCell"

class FavoritesViewController: UIViewController {
     var recipes : [Recipe] = []
    
     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoriteView: UIView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadFavorite()
        self.title = "Favorites"
    }
    private func showNoFavoritesView(_ value : Bool){
        self.noFavoriteView.isHidden = !value
    }
    
    // MARK: - Setup
    private func setup(){
        self.tableView.register(UINib.init(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)//register Cell
    }
    
     // MARK: - Data
    private func reloadFavorite(){
        self.recipes = Recipe.favorites
        self.tableView.reloadData()
        showNoFavoritesView((self.recipes.isEmpty ? true : false))
    }
    
    
    
    // MARK: - NAVIGATION
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
extension FavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Favorite_Details", sender: self)
    }
    
}
// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource{
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


