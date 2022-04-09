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
    
   
    
    
//    func newWorkout () {
//        
//        let user = Auth.auth().currentUser
//        
//        if let user = user {
//        
//            let uid = user.uid
//        //}
//            
//            let docId = db.collection("users").document(uid).collection(nameMyWorkout).document()
//            let db = db.collection("users").document(uid)
//                .collection(nameMyWorkout).document().setData([
//                    
//                    "idUser" : uid,
//                    "idUser" : docId,
//                    "Name Workout" : nameMyWorkout,
//                    "Description" : descriptionMyWorkout,
//                    "TimesTramp" : FieldValue.serverTimestamp(),
//                    
//                                ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//            
//            }
//            
//        print("test func newTraining...\(db)")
//    }
//    }
    
}

