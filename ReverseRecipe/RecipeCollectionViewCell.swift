//
//  RecipeCollectionViewCell.swift
//  ReverseRecipe
//
//  Created by APPLE on 13/11/22.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func goToLink(_ sender: Any) {
        
    }
}
