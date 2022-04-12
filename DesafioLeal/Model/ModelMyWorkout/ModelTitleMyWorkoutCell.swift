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
    @IBOutlet weak var cornerViewButtonReturn: UIView!
    @IBOutlet weak var buttonReturn : UIButton!
    
    
    func setupDesign () {
        
        cornerViewButtonReturn.changeDesigneView(cornerRadius: cornerViewButtonReturn.frame.height/2, shadow: CGSize(width: 0, height: 0), shadowOpacity: 0)
        
    }
    
    func setupView () {
        
        cardViewTitle.changeDesigneView(cornerRadius: 18, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    
    func setupValues (titleMyWorkout: String) {
        
            titleWorkoutLabel.text = titleMyWorkout
//        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
//        labelExercisesTitle.textColor = .blue
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
}
