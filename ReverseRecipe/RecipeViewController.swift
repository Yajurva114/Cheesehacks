//
//  RecipeViewController.swift
//  ReverseRecipe
//
//  Created by APPLE on 12/11/22.
//

import UIKit
import SDWebImage

class RecipeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numIngredients: UILabel!
    
    @IBOutlet weak var lbsoffood: UILabel!
    @IBOutlet weak var andsaved: UILabel!
    @IBOutlet weak var weightIng: UILabel!
    
    
    var dataSource : [[String: Any]] = []
    
    //Data.recipes["Butter"]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
        
        numIngredients.text = "You selected \(Data.selectedIngredients.count) ingredients"
        numIngredients.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        
        weightIng.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        lbsoffood.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        andsaved.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        
        fetchData()
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension RecipeViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(dataSource.count == 0){
            let alert = UIAlertController(title: "Error", message: "Please select atleast 1 ingredient", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: {})
            return 0
        }else{
            return dataSource.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
        cell.recipeName.text = dataSource[indexPath.row]["name"] as! String
        let url = URL(string: dataSource[indexPath.row]["imageLink"] as! String)
        
        cell.recipeImage.sd_setImage(with: url)
        cell.recipeImage.clipsToBounds = true
        cell.recipeImage.contentMode = .scaleAspectFill
        
        cell.mainView.layer.borderWidth = 0
        cell.mainView.layer.borderColor = UIColor.gray.cgColor
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.7
                cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.masksToBounds = false
        
        //cell.mainView.layer.cornerRadius = 10
        
        
        
        //cell.mainView.clipsToBounds = true
        
        
        return cell
    }
    
    
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 35, bottom: 0, right: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var cell = collectionView.cellForItem(at: indexPath) as! RecipeCollectionViewCell
        
        let urlString = dataSource[indexPath.row]["link"] as! String
        openUrl(urlString: urlString)
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func fetchData(){
        
        if (Data.selectedIngredients.count == 0){
            dataSource = []
        } else if (Data.selectedIngredients.count == 1) {
          dataSource = [
          
            [
                "name" : "Ghee",
                "link" : "https://downshiftology.com/recipes/how-to-make-ghee/",
                "ingredients" : ["Butter"],
                "imageLink" : "https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2017/02/how-to-make-ghee-1-3.jpg"
            ]
          ]
            weightIng.text = "0.13"
        } else if(Data.selectedIngredients.count == 3){
            dataSource = [
                [
                    "name" : "Ghee",
                    "link" : "https://downshiftology.com/recipes/how-to-make-ghee/",
                    "ingredients" : ["Butter"],
                    "imageLink" : "https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2017/02/how-to-make-ghee-1-3.jpg"
                ],
                [
                "name" : "Garlic Butter",
                "link" : "https://www.marthastewart.com/319245/garlic-butter",
                "ingredients" : ["Butter", "Garlic"],
                "imageLink" : "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-300%2Fd17%2F5125_040210_eggie%2F5125_040210_eggie_hd.jpg%3Fitok%3D1-iUEsE1"
            ],[
                "name" : "Microwave Rice",
                "link" : "https://www.justapinch.com/recipes/side/rice-side/microwave-rice.html?r=34",
                "ingredients" : ["Butter", "Rice"],
                "imageLink" : "https://lh3.googleusercontent.com/YyDZf1sbAhmb2J1jvdPo_Xa5mSvRzFyQp1YoeLh1ZLPy6FWr9jx-cnILQ1EbfR4Afe7xqtkBreQyJfHMInfSdbMjHUwvwFs8dMP7kW8=w523-h411-p"
            ],[
                "name" : "Pickled Garlic",
        "link" : "https://www.thehealthyhomeeconomist.com/pickled-garlic/",
        "ingredients" : ["Garlic"] ,
        "imageLink" : "https://www.thehealthyhomeeconomist.com/wp-content/uploads/2017/05/traditionally-pickled-garlic.jpg"
        ]
            
            ]
            
            weightIng.text = "1.53"
        }else if(Data.selectedIngredients.count == 6){
            
            dataSource = [
            
                [
                "name" : "Garlic Butter",
                "link" : "https://www.marthastewart.com/319245/garlic-butter",
                "ingredients" : ["Butter", "Garlic"],
                "imageLink" : "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-300%2Fd17%2F5125_040210_eggie%2F5125_040210_eggie_hd.jpg%3Fitok%3D1-iUEsE1"
            ],

            [
                "name" : "Ghee",
                "link" : "https://downshiftology.com/recipes/how-to-make-ghee/",
                "ingredients" : ["Butter"],
                "imageLink" : "https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2017/02/how-to-make-ghee-1-3.jpg"
            ],

            [
                "name" : "Caramelized Onion",
                "link" : "https://www.orwhateveryoudo.com/2014/01/caramelizing-onions.html",
                "ingredients" : ["Butter", "Onion"],
                "imageLink" : "https://www.orwhateveryoudo.com/wp-content/uploads/2014/01/Copy-of-Caramelized-Onions-735x1103.jpg.webp"
            ],

            [
                "name" : "Garlic Dipping Sauce",
                "link" : "https://www.oliviascuisine.com/roasted-garlic-dipping-sauce/",
                "ingredients" : ["Butter", "Onion", "Olive Oil"],
                "imageLink" : "https://www.oliviascuisine.com/wp-content/uploads/2016/02/Garlic.jpg"
            ],

            [
                "name" : "Perfect Caramelized Onions",
                "link" : "https://fussfreeflavours.com/recipe-how-to-make-caramelized-onions/",
                "ingredients" : ["Butter", "Onion", "Olive Oil", "Garlic"],
                "imageLink" : "https://fussfreeflavours.com/wp-content/uploads/2015/07/how-to-make-perfect-sticky-caramelized-onions.jpg"
            ],

            [
                "name" : "Microwave Risotto",
                "link" : "https://recipes.timesofindia.com/us/recipes/microwave-risotto/rs57788980.cms",
                "ingredients" : ["Garlic", "Butter", "Onion", "Olive Oil", "Rice"],
                "imageLink" : "https://static.toiimg.com/thumb/57788980.cms?imgsize=2551809&width=509&height=340"
            ],

            [
                "name" : "Microwave Rice",
                "link" : "https://www.justapinch.com/recipes/side/rice-side/microwave-rice.html?r=34",
                "ingredients" : ["Butter", "Rice"],
                "imageLink" : "https://lh3.googleusercontent.com/YyDZf1sbAhmb2J1jvdPo_Xa5mSvRzFyQp1YoeLh1ZLPy6FWr9jx-cnILQ1EbfR4Afe7xqtkBreQyJfHMInfSdbMjHUwvwFs8dMP7kW8=w523-h411-p"
            ],

            [
                "name" : "Pan Seared Chicken Breast",
                "link" : "https://cravingtasty.com/pan-seared-baked-chicken-breast/",
                "ingredients" :  ["Chicken Breast", "Garlic", "Olive Oil", "Butter"],
                "imageLink" : "https://cravingtasty.com/wp-content/uploads/2017/07/Pan-Seared-Baked-Chicken-Breast.jpg"
            ],[
                "name" : "Sliced Onion",
                "link" : "https://www.simplyrecipes.com/recipes/how_to_slice_an_onion/",
                "ingredients" : ["Onion"],
                "imageLink" : "https://www.simplyrecipes.com/thmb/loNKwLewps0J8oJgLlZXFg8PJfg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2018__05__how-to-slice-onion-pinterest-long-e547cc46d7b643e79d714d632967197d.jpg"
            ],[
                "name" : "Garlicky Chicken with Onions",
                "link" : "https://barefeetinthekitchen.com/garlicky-chicken-with-onions/",
                "ingredients" :  ["Chicken Breast", "Garlic", "Olive Oil", "Onion"],
                "imageLink" : "https://barefeetinthekitchen.com/wp-content/uploads/2012/09/garlicky-chicken-with-onions-3.jpg"
            ],[
                "name" : "Shredded Chicken",
                "link" : "https://www.meatloafandmelodrama.com/easy-crock-pot-shredded-chicken/",
                "ingredients" : ["Chicken Breast", "Garlic", "Olive Oil", "Onion"],
                "imageLink" : "https://www.meatloafandmelodrama.com/wp-content/uploads/2016/05/crock-pot-shredded-chicken.jpg"
            ],[
                "name" : "Pan Seared Chicken Breast",
                "link" : "https://cravingtasty.com/pan-seared-baked-chicken-breast/",
                "ingredients" : ["Chicken Breast", "Garlic", "Olive Oil", "Butter"],
                "imageLink" : "https://cravingtasty.com/wp-content/uploads/2017/07/Pan-Seared-Baked-Chicken-Breast.jpg"
            ]
            ]
            
            weightIng.text = "3.72"
        }
        
        
    }
        
}
