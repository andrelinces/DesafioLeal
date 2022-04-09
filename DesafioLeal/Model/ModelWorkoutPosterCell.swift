//
//  ModelWorkoutPosterCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 05/04/22.
//

import Foundation
import UIKit

class ModelWorkoutPosterCell: UITableViewCell {
    
    @IBOutlet weak var cardViewWorkout: UIView!
    @IBOutlet weak var imageViewWorkout: UIImageView!
    @IBOutlet weak var titleLabelWorkout: UILabel!
    @IBOutlet weak var descriptionLabelWorkout: UILabel!
    
    func setupDesign () {

        cardViewWorkout.borderDesigneView(cornerRadius: 38)

    }
    
    func setupView () {
        
        cardViewWorkout.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    func setupValues (descriptionWorkout: String) {
        
//        labelExercisesTitle.text = exercisesTitle
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        descriptionLabelWorkout.text = "Choose a workout or build your own!"
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
    func setupImage (imagePosterWorkout: String, titleWorkout: String) {
        
        imageViewWorkout.downloaded(from: imagePosterWorkout)
//        imageViewWorkout.contentMode = .scaleAspectFill
//        imageViewWorkout.clipsToBounds = (2 != 0)
//        imageViewWorkout.borderDesigneView(cornerRadius: 8)
        
        //imageViewWorkout.image = UIImage(named: "academia")
        titleLabelWorkout.text = titleWorkout
        
    }
    
}

