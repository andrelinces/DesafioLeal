//
//  ModelUserMyWorkoutCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 10/04/22.
//

import UIKit

class ModelUserMyWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var cardViewMyWorkout: UIView!
    @IBOutlet weak var labelNameWorkout: UILabel!
    @IBOutlet weak var labelDateWorkout: UILabel!
    @IBOutlet weak var labelDescriptionWorkout: UILabel!
    
    
    func setupDesign () {

        cardViewMyWorkout.borderDesigneView(cornerRadius: 38)

    }
    
    func setupView () {
        
        cardViewMyWorkout.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    
    func setupValues (nameWorkout: String, dateWorkout: String, descriptionWorkout: String) {
        
        labelNameWorkout.text = nameWorkout
        labelDateWorkout.text = dateWorkout
        labelDescriptionWorkout.text = descriptionWorkout
        
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
    
    
}
    
    

