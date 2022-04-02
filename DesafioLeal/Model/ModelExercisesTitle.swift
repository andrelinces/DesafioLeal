//
//  ModelExercisesTitle.swift
//  DesafioLeal
//
//  Created by Andre Linces on 02/04/22.
//

import UIKit

protocol ModelExercisesTitleCellCallBack: class {
    
   // func actionReturn ()
    
}
class ModelExercisesTitle: tableViewCompatible {
    internal init (delegate: ModelExercisesTitleCellCallBack?, navigationController : UINavigationController?, exercisesTitle: String){
        self.delegate = delegate
        self.exercisesTitle = exercisesTitle
    }
    
    open weak var delegate:ModelExercisesTitleCellCallBack?
    
    var reuseIdentifier: String {
        
        return "ModelExercisesTitleCellIdentifier"
    }
    
    //Variables of the inicilizaing.
    var exercisesTitle: String
    var navigationController : UINavigationController?
    

    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelExercisesTitleCell {
            
            //cell.setupDesign()
            //cell.setupImage(imageExercisesPoster: imageExercisesPoster)
            cell.setupValues(exercisesTitle: "Exercises" )
            cell.contentView.backgroundColor = .blue
            
            
            
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
    
    }
