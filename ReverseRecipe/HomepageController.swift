//
//  ViewController.swift
//  ReverseRecipe
//
//  Created by APPLE on 12/11/22.
//

import UIKit

class HomepageController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var facts: UILabel!
    
    let quotes: [String] = [
        "About 1 in 10 people worldwide are suffering from hunger \n" +
        "- United Nations",
         "Nearly 1 in 3 people lack regular access to adequate food \n" +
        "- United Nations",
        "149.2 million children under age 5 suffer from stunted growth due to food insecurity \n" + "- United Nations",
        "A total of 50 million people in 45 countries are teetering on the edge of famine \n" +
        "- United Nations",
         "Americans throw out more than 1,250 calories per day per person \n" +
        "- United Nations",
         "Food is the No. 1 thing in America’s landfills \n" +
        "- United Nations",
         "Nearly half of household fruits and vegetables get thrown out \n" +
        "- United Nations",
         "The average family of four loses $1,800 a year in wasted food \n" +
        "- United Nations",
        "College students produce 112 pounds of waste per student per school year; twice as much than that produced by corporate employees \n" +
        "- United Nations",
        "College campuses nationwide produce 22 million pounds of food waste annually \n" +
        "- United Nations"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = startButton.frame.height / 2
        startButton.layer.borderColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00).cgColor
        startButton.layer.borderWidth = 2
        startButton.titleLabel?.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        startButton.isHighlighted = false
        // Do any additional setup after loading the view.
        
        facts.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.26, alpha: 1.00)
        facts.text = quotes[Int.random(in: 0...7)]
    }

    @IBAction func launchApp(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "IngredientViewController") as! IngredientViewController
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    
}

