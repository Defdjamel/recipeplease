//
//  DetailsRecipeTableViewController.swift
//  reciplease
//
//  Created by james on 26/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
private let headerCellIdentier = "HeaderCellIdentier"
private let ingredientCellIdentier = "IngredientsTableViewCell"
class DetailsRecipeTableViewController: UIViewController {
    var curentRecipe : Recipe!
    
     @IBOutlet weak var tableView: UITableView!
     // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    func setup(){
        //register Cell Nib
        self.tableView.register(UINib.init(nibName: ingredientCellIdentier, bundle: Bundle.main), forCellReuseIdentifier: ingredientCellIdentier)
    }

    // MARK: - Data
    
    
}


// MARK: - UITableViewDelegate
extension DetailsRecipeTableViewController: UITableViewDelegate{
   
}
// MARK: - UITableViewDataSource
extension DetailsRecipeTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let ingredients = curentRecipe.ingredients {
                return ingredients.count
            }
            return 0
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentier,
                                                     for: indexPath) as! HeaderDetailsTableViewCell
            cell.setRecipe(curentRecipe)
            return cell
        }
        else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ingredientCellIdentier,
                                                         for: indexPath) as! IngredientsTableViewCell
                return cell
            
        }
        
        
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0://Header size Cell
           return 180
        case 1://Ingredient size Cell
            return 60
        default:
           return  0
        }
    }
}
