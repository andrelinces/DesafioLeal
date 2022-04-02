//
//  ModelExercisesPosterCell.swift
//  DesafioLeal
//
//  Created by Andre Linces on 02/04/22.
//

import UIKit

import Kingfisher
import FirebaseStorage

class ModelExercisesPosterCell: UITableViewCell {

    @IBOutlet weak var imageViewExercises: UIImageView!
    @IBOutlet weak var labelTest: UILabel!

//func setupDesign () {
//
//    cornerViewButtonReturn.changeDesigneView(cornerRadius: cornerViewButtonReturn.frame.height/2, shadow: CGSize(width: 0, height: 0), shadowOpacity: 0)
//
//}
    
    // Create a reference to the file you want to download
    //let islandRef = storageRef.child("images/island.jpg")
    
    

func setupValues (imageExercisesPoster: String) {
    
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

    imageViewExercises.downloaded(from: "https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22")
    imageViewExercises.contentMode = .scaleAspectFill
    imageViewExercises.image = UIImage(named: imageExercisesPoster)
    
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
