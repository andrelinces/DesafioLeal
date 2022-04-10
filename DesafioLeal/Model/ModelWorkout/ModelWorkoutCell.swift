//
//  ModelWorkoutCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 06/04/22.
//

import UIKit
import Foundation

class ModelWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var cardViewWorkout: UIView!
    @IBOutlet weak var imageViewWorkout: UIImageView!
    @IBOutlet weak var labelWorkout: UILabel!
    
    @IBOutlet weak var buttonPullDonwMenu: UIButton!
    
    
    
    
    @IBAction func buttonMenu(_ sender: Any) {
     
        
        //buttonPullDonwMenu.menu?.options.rawValue
        
        enum PaperSize: String {
            case A4, A5, Letter, Legal
        }

        let selectedSize = PaperSize.Letter
        print(selectedSize.rawValue)
        // Prints "Letter"

        print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        // Prints "true"
        
        
    }
    
    
    func setupDesign () {

        cardViewWorkout.borderDesigneView(cornerRadius: 38)

    }
    
    func setupView () {
        
        cardViewWorkout.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    func setupValues (exercisesTitle: String) {
        
//        labelExercisesTitle.text = exercisesTitle
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
    func setupImage (imageWorkout: String, myWorkout: String) {
        
        imageViewWorkout.downloaded(from: imageWorkout)
        imageViewWorkout.contentMode = .scaleAspectFill
        imageViewWorkout.clipsToBounds = (2 != 0)
        imageViewWorkout.borderDesigneView(cornerRadius: 18)
        imageViewWorkout.image = UIImage(named: "muculacaoPoster2")
        labelWorkout.text = myWorkout
        
    }
    
}
