//
//  ModelTitleMyWorkoutCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

class ModelTitleMyWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var cardViewTitle: UIView!
    @IBOutlet weak var titleWorkoutLabel: UILabel!
    @IBOutlet weak var buttonMenuMyWorkout: UIButton!
    
    
    
    func setupValues (titleMyWorkout: String) {
        
            titleWorkoutLabel.text = titleMyWorkout
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
}
