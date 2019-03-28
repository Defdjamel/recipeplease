//
//  SearchTableViewCell.swift
//  reciplease
//
//  Created by james on 26/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     // MARK:  - DATA
     func setIngredient(_ name : String){
        self.titleLabel.text = name
    }
    
}
