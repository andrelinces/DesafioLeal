//
//  ModelExercisesIPoster.swift
//  DesafioLeal
//
//  Created by Andre Linces on 01/04/22.
//

import UIKit

protocol ModelExercisesPosterCallBack: class {
    
   // func actionReturn ()
    
}
class ModelExercisesPoster: tableViewCompatible {
    internal init (delegate: ModelExercisesPosterCallBack?, navigationController : UINavigationController?, imageExercisesPoster: String){
        self.delegate = delegate
        self.imageExercisesPoster = imageExercisesPoster
    }
    
    open weak var delegate:ModelExercisesPosterCallBack?
    
    var reuseIdentifier: String {
        
        return "ModelExercisesPosterCellIdentifier"
    }
    
    //Variables of the inicilizaing.
    var imageExercisesPoster: String
    var navigationController : UINavigationController?
    

    //cell.img.sd_setImage(with: ref2)
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelExercisesPosterCell {
            
            //cell.setupDesign()
            //cell.setupImage(imageExercisesPoster: imageExercisesPoster)
            cell.setupValues(imageExercisesPoster: imageExercisesPoster)
            
            
            
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

