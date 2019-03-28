//
//  ListRecipeTableViewCell.swift
//  reciplease
//
//  Created by james on 27/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import Kingfisher

class ListRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rateView: RecipeRateView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.recipeImage.layer.masksToBounds = true
        self.recipeImage.kf.indicatorType = .activity
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRecipe(_ recipe : RecipeInterface) {
        self.titleLabel.text = recipe.title
        self.subtitleLabel.text = recipe.subtitle
        if let imageUrl = recipe.imageUrl {
            let url = URL(string: imageUrl)
            self.recipeImage.kf.setImage(with: url)
        }
        else{
            self.recipeImage.image = nil
        }
        //rateView
        self.rateView.setRecipe(recipe)
        
    }
    
}
