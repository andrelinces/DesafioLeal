//
//  ModelMyWorkoutCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

class ModelMyWorkoutCell: UITableViewCell{
    
    @IBOutlet weak var cardViewWorkout: UIView!
    @IBOutlet weak var nameWorkoutTitleLabel: UILabel!
   
    @IBOutlet weak var descriptionWorkoutLabel: UILabel!
    @IBOutlet weak var descriptionWorkoutField: UITextField!
    
    
    
    func setupDesign () {

        cardViewWorkout.borderDesigneView(cornerRadius: 38)

    }
    
    func setupView () {
        
        cardViewWorkout.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    func setupValues (nameTitleMyWorkout: String, nameWorkout: String, descriptionMyWorkout: String ) {
        
        nameWorkoutTitleLabel.text = nameTitleMyWorkout
        //nameWorkoutField.text = nameWorkout
        descriptionWorkoutField.text = descriptionMyWorkout
        
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
}

