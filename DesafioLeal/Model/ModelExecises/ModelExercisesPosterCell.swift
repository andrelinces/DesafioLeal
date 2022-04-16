//
//  ModelExercisesPosterCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 02/04/22.
//

import UIKit


import FirebaseStorage

class ModelExercisesPosterCell: UITableViewCell {

    @IBOutlet weak var imageViewExercises: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelObservation: UILabel!
    @IBOutlet weak var cardViewPoster: UIView!
    @IBOutlet weak var buttonCheck: UIButton!
    

func setupDesign () {

    cardViewPoster.borderDesigneView(cornerRadius: 8)

}
    func setupView () {
        
        cardViewPoster.changeDesigneView(cornerRadius: 18, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.8)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            cardViewPoster.backgroundColor = UIColor.green
        } else {
            cardViewPoster.backgroundColor = UIColor.opaqueSeparator
        }
    }
    

    func setupValues (imageExercisesPoster: String, exercisesTitle: String, observation: String) {
    

    //print("numero de subview\(imageViewExercises.layer.sublayers?.count)")
    //https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22
    
    imageViewExercises.downloaded(from: imageExercisesPoster)
    imageViewExercises.contentMode = .scaleAspectFill
    imageViewExercises.clipsToBounds = (2 != 0)
    imageViewExercises.borderDesigneView(cornerRadius: 8)
    imageViewExercises.image = UIImage(named: imageExercisesPoster)
    //cardViewPoster.backgroundColor = .systemFill
        
        labelTitle.text = exercisesTitle
        labelObservation.text = observation
    }
}
