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
        
        cardViewPoster.changeDesigneView(cornerRadius: 8, shadow: CGSize(width: 0, height: 2), shadowOpacity: 0.3)
        
    }
    // Create a reference to the file you want to download
    //let islandRef = storageRef.child("images/island.jpg")
    
    

    func setupValues (imageExercisesPoster: String, exercisesTitle: String, observation: String) {
    
//    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22")
//    imageViewExercises.kf.setImage(with: url)
    
    //imageViewExercises.contentMode = .scaleAspectFill
    
//    let refStorage = Storage.storage().reference().child("https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22")
//
//    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//    refStorage.getData(maxSize: 1 * 1024 * 1024) { data, error in
//      if let error = error {
//        // Uh-oh, an error occurred!
//      } else {
//        // Data for "images/island.jpg" is returned
//        let imageExercisesPoster = UIImage(data: data!)
//          imageViewExercises.image = UIImage(named: imageExercisesPoster)
//      }
//    }
    
    //"gs://<your-firebase-storage-bucket>/images/stars.jpg"
    
    
    
    
    

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
    
//
//    //In case gradient don't have apllyed correcty.
//    if imageViewExercises.layer.sublayers == nil {
//        imageViewExercises.addBlackGradientLayerInForeground(frame: imageViewMovie.bounds, colors:[.clear, .black])
//    }
}
    
//    func setupImage (imageExercisesPoster : String) {


//        imageViewExercises.image = UIImage(named: imageExercisesPoster)

//}
}
