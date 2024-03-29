//
//  ModelExercisesIPoster.swift
//  DesafioLeal
//
//  Created by Andre Linces on 01/04/22.
//

import UIKit
import FirebaseFirestore

protocol ModelExercisesPosterCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
    func actionReturn ()
}

var db = Firestore.firestore()

class ModelExercisesPoster: tableViewCompatible {
    internal init (delegate: ModelExercisesPosterCallBack?, navigationController : UINavigationController?, imageExercisesPoster: String, exercisesTitle: String, observation: String){
        self.delegate = delegate
        self.imageExercisesPoster = imageExercisesPoster
        self.exercisesTitle = exercisesTitle
        self.observation = observation
        
    }
    
    open weak var delegate:ModelExercisesPosterCallBack?
    
    var reuseIdentifier: String {
        
        return "ModelExercisesPosterCellIdentifier"
    }
    
   
    
    //Variables of the inicilizaing.
    var imageExercisesPoster: String
    var exercisesTitle: String
    var observation: String
    var navigationController : UINavigationController?
    
   
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelExercisesPosterCell {
            
            cell.setupView()
            
            cell.setupDesign()
            
            //collor cardview
            cell.setSelected(true, animated: true)
            
            cell.setupValues(imageExercisesPoster: imageExercisesPoster, exercisesTitle: exercisesTitle, observation: observation)
            
            
            //Adding clicks in card from tableview
            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
            gestureClickCard.indexPath = indexpath
            
            cell.cardViewPoster.addGestureRecognizer(gestureClickCard)
            
           // let listTest = db.collection("exercices").document("Categories").collection("Legs")
            
           
            return cell
            
            
        }else{
            
            return UITableViewCell()
            
        }
    }
    //Function of the return button, used into main view.
    @objc func actionReturn(sender : UITapGestureRecognizer){

        delegate?.actionReturn()
    }
    
    @objc func actionClickCardView (sender: myTapCustom) {
        delegate?.actionClickCardView(indexPath: sender.indexPath!)
    }

    class myTapCustom: UITapGestureRecognizer {

        var indexPath: IndexPath?
        
    }
    
    }

