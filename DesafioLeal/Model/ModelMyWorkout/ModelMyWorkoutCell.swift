//
//  ModelMyWorkoutCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit


class ModelMyWorkoutCell: UITableViewCell{
    
    @IBOutlet weak var cardViewWorkout: UIView!
   // @IBOutlet weak var WorkoutTitleLabel: UILabel!
    //@IBOutlet weak var nameMyWorkoutLabel: UILabel!
    @IBOutlet weak var nameMyWorkoutField: UITextField!
   // @IBOutlet weak var descriptionMyWorkoutLabel: UILabel!
    @IBOutlet weak var descriptionMyWorkoutField: UITextField!
    
    
    
    func setupDesign () {

        cardViewWorkout.borderDesigneView(cornerRadius: 38)

    }
    
    func setupView () {
        
        cardViewWorkout.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    func setupValues (nameMyWorkout: String, descriptionMyWorkout: String ) {
        
        //WorkoutTitleLabel.text = WorkoutTitle
       // nameMyWorkoutLabel.text = labelMyWorkout
        
        nameMyWorkoutField.text = nameMyWorkout
       // descriptionMyWorkoutLabel.text = labelDescriptionMyWorkout
        descriptionMyWorkoutField.text = descriptionMyWorkout
        
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
   
    
    
}

