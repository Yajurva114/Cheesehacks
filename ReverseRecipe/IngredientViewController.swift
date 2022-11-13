//
//  IngredientViewController.swift
//  ReverseRecipe
//
//  Created by APPLE on 12/11/22.
//

import UIKit

class IngredientViewController: UIViewController {

    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource : [String]! = Data.ingredients
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var counter = 0
    var selectedIngredients:  [String]! = []
    var filter : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bund = Bundle(for: IngredientCollectionViewCell.self)
        let nib = UINib(nibName: "IngredientCollectionViewCell", bundle: bund)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "IngredientCollectionViewCell")
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        filter = Data.ingredients
        recipeButton.titleLabel?.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        recipeButton.layer.borderColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00).cgColor
        recipeButton.layer.borderWidth = 2
        recipeButton.layer.cornerRadius = recipeButton.frame.height / 2
        recipeButton.isHighlighted = false
        searchBar.clipsToBounds = true
        recipeButton.adjustsImageWhenHighlighted = false
        
        
    }
    
    @IBAction func findRecipes(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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

extension IngredientViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
        
        
        cell.mainView.layer.cornerRadius = 10
        cell.mainView.backgroundColor = UIColor.white
        
        //Stylising the cell
      //  cell.mainView.layer.borderWidth = 2
        cell.mainView.layer.cornerRadius = 10
       // cell.mainView.layer.borderColor = UIColor.darkGray.cgColor
        cell.mainView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        cell.name.textColor = .darkGray
        
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.masksToBounds = false
        
        
        
        cell.name.text = filter[indexPath.row]
        cell.tag = 0
        return cell

        
    }
    
}

extension IngredientViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var cell = collectionView.cellForItem(at: indexPath) as! IngredientCollectionViewCell
        
        if(cell.tag == 0){
//            cell.mainView.backgroundColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
            cell.layer.shadowColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00).cgColor
            cell.name.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
            cell.layer.shadowOpacity = 1
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00).cgColor
            cell.layer.cornerRadius = 10
            cell.tag = 1
            Data.selectedIngredients.append(cell.name.text as! String)
           
        }else{
//            cell.mainView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
            cell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.name.textColor = .darkGray
            cell.tag = 0
            cell.layer.shadowOpacity = 0.7
            cell.layer.borderWidth = 0
            
            // cell.name.textColor =
            
            let index2 = Data.selectedIngredients.firstIndex(of: cell.name.text as! String)
            Data.selectedIngredients.remove(at: index2!)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 35, bottom: 0, right: 35)
    }
    
}

extension IngredientViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.lowercased()
        
        if (searchText.isEmpty){
            filter = Data.ingredients
            collectionView.reloadData()
            
            
        }else{
            var temp: [String]! = []
        for val in dataSource{
            if (val.lowercased().hasPrefix(searchText)){
                temp.append(val)
            }
        }
            filter = temp
            collectionView.reloadData()
    }
        
    }
    
        
        
}
