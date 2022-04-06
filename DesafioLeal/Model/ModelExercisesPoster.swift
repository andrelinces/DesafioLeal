//
//  ModelExercisesIPoster.swift
//  DesafioLeal
//
//  Created by Andre Linces on 01/04/22.
//

import UIKit

protocol ModelExercisesPosterCallBack: class {
    
    //func actionClickCardView ()
    
}
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
    

    //cell.img.sd_setImage(with: ref2)
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelExercisesPosterCell {
            
            cell.setupView()
            
            cell.setupDesign()
            
            cell.setupValues(imageExercisesPoster: imageExercisesPoster, exercisesTitle: exercisesTitle, observation: observation)
            
            cell.contentView.backgroundColor = .orange
            
            
            //MARK: Return button action on movie details screen, this method is used in main view..
//            cell.buttonReturn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionReturn)))
            
            
            return cell
            
            
        }else{
            
            return UITableViewCell()
            
        }
    }
    //Function of the return button, used into main view.
//    @objc func actionReturn(sender : UITapGestureRecognizer){
//
//        delegate?.actionReturn()
//    }
    
//    @objc func actionClickCardView (sender: myTapCustom) {
//        delegate?.actionClickCardView(indexPath: sender.indexPath!)
//    }
//    
//    class myTapCustom: UITapGestureRecognizer {
//        
//        var indexPath: IndexPath?
//        
//    }
    
    }

