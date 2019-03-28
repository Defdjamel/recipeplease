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
    var buttonFavorite : UIButton!
    
     @IBOutlet weak var tableView: UITableView!
     // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addFavoriteBtn()
        updateBtnFavorite()
        getDetailsRecipe()
    }
    func updateBtnFavorite(){
        buttonFavorite.isSelected = self.curentRecipe.isFavorite
    }
    // MARK: - Setup
    func setup(){
        //register Cell Nib
        self.tableView.register(UINib.init(nibName: ingredientCellIdentier, bundle: Bundle.main), forCellReuseIdentifier: ingredientCellIdentier)
    }
    
    func addFavoriteBtn(){
         buttonFavorite = UIButton.init(type: .custom)
        buttonFavorite.setImage(UIImage.init(named: "top_off"), for: .normal)
        buttonFavorite.setImage(UIImage.init(named: "top_on"), for: .selected)
        buttonFavorite.setImage(UIImage.init(named: "top_on"), for: .highlighted)
        buttonFavorite.addTarget(self, action: #selector(onClickFavorite), for:.touchUpInside)
        buttonFavorite.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: buttonFavorite)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: - Data
    func getDetailsRecipe(){
        NetworkManager.sharedInstance.detailsRecipe(curentRecipe, success: { (recipe) in
            
            self.curentRecipe = recipe
            self.tableView.reloadData()
        }) {
            
        }
    }
    
     // MARK: - Action
    @objc func onClickFavorite(){
        self.curentRecipe.setFavorite()
        updateBtnFavorite()
    
    }
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
            if let ingredients = curentRecipe.ingredientLines {
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
            if  let ingredient = curentRecipe.ingredientLines?.allObjects[indexPath.row] as? IngredientLine, let name = ingredient.name  {
                cell.setIngredient(name)
            }
            return cell
            
        }
    }
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return DetailsHeaderSectionView.instanceFromNib() as? UIView
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  (section == 1 ) ? 60 : 0
    }
}
