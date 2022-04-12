//
//  ModelExercisesTitleCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 02/04/22.
//

import UIKit

class ModelExercisesTitleCell: UITableViewCell {
    
    @IBOutlet weak var labelExercisesTitle: UILabel!
    @IBOutlet weak var cardViewTitle: UIView!
    @IBOutlet weak var cornerViewButtonReturn : UIView!
    @IBOutlet weak var buttonReturn : UIButton!
  
    
    func setupDesign () {

        cardViewTitle.changeDesigneView(cornerRadius: 28, shadow: CGSize(width: 0, height: 2) , shadowOpacity: 0.3)
        //cardViewTitle.layer.backgroundColor = .init(srgbRed: 55, green: 90, blue: 30, alpha: 1)
        
        //cardViewTitle.backgroundColor = .lightGray
        cornerViewButtonReturn.changeDesigneView(cornerRadius: cornerViewButtonReturn.frame.height/2, shadow: CGSize(width: 0, height: 0), shadowOpacity: 0)
        
    }

    func setupValues (exercisesTitle: String) {
        
        labelExercisesTitle.text = exercisesTitle
        labelExercisesTitle.font = .boldSystemFont(ofSize: 30)
        labelExercisesTitle.textColor = .black
        
        
        //cardViewTitle.backgroundColor = .lightGray
    }
    
    
}
