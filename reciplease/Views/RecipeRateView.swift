//
//  RecipeRateView.swift
//  reciplease
//
//  Created by james on 27/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

class RecipeRateView: UIView {

    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    /*
     //required init
     //add Nib to storyBoard
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)) , owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    func setRecipe(_ recipe: RecipeInterface){
        self.rateLabel.text = recipe.rate
        self.timerLabel.text = recipe.time
    }

}
