//
//  HeaderDetailsTableViewCell.swift
//  reciplease
//
//  Created by james on 28/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

class HeaderDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateView: RecipeRateView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK:  - DATA
     func setRecipe(_ recipe : RecipeInterface) {
        self.rateView.setRecipe(recipe)
        self.titleLabel.text = recipe.title
        if let imageUrl = recipe.imageUrl {
            let url = URL(string: imageUrl)
            self.recipeImage.kf.setImage(with: url)
        }
        else{
            self.recipeImage.image = nil
        }
        
    }

}
