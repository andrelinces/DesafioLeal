//
//  ModelMyWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

protocol ModelMyWorkoutCellCallBack: class {
    
    
}

class ModelMyWorkout: tableViewCompatible {
    internal init(delegate: ModelMyWorkoutCellCallBack, navigationController:  UINavigationController?, nameTitleMyWorkout: String, nameMyWorkout: String, descriptionMyWorkout: String) {
        self.nameTitleMyWorkout = nameTitleMyWorkout
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
    }
    
    
    var reuseIdentifier: String {
        
        "ModelMyWorkoutCellIdentifier"
        
    }
    open weak var delegate : ModelMyWorkoutCellCallBack?
    
    var nameTitleMyWorkout :  String = " "
    var nameMyWorkout: String = " "
    var descriptionMyWorkout: String = " "
    var navigationController : UINavigationController?
    
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelMyWorkoutCell {
        
            
            cell.setupView()
            cell.setupDesign()
            cell.setupValues(nameTitleMyWorkout: "Name your Workout", nameWorkout: nameMyWorkout, descriptionMyWorkout: descriptionMyWorkout)
            //cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //Adding clicks in card from tableview
//            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
//            gestureClickCard.indexPath = indexpath
//
//            cell.cardViewTitle.addGestureRecognizer(gestureClickCard)
            
            return cell
            
            
        }else{
            
            return UITableViewCell()
            
        }
        
    }
    
    
    
}
