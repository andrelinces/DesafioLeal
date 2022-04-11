//
//  ModelMyWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

protocol ModelMyWorkoutCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
}

class ModelMyWorkout: tableViewCompatible {
    internal init(delegate: ModelMyWorkoutCellCallBack, navigationController:  UINavigationController?, nameMyWorkout: String, descriptionMyWorkout: String) {
        
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
        //self.nameTitleMyWorkout = nameTitleMyWorkout
    }
    
    var reuseIdentifier: String {
        
        "ModelMyWorkoutCellIdentifier"
        
    }
    open weak var delegate : ModelMyWorkoutCellCallBack?
    
 //   var nameTitleMyWorkout :  String
//    var nameMyWorkoutTitle: String = " "
    var nameMyWorkout: String
    var descriptionMyWorkout: String 
    //var navigationController : UINavigationController?
    
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelMyWorkoutCell {
        
            
            cell.setupView()
            cell.setupDesign()
            cell.setupValues(nameMyWorkout: nameMyWorkout, descriptionMyWorkout: descriptionMyWorkout)
            //cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //[Adding clicks in card from tableview]
            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
            gestureClickCard.indexPath = indexpath

            cell.cardViewWorkout.addGestureRecognizer(gestureClickCard)
            
            return cell
            
            
        }else{
            
            return UITableViewCell()
            
        }
        
    }
    
    @objc func actionClickCardView (sender: myTapCustom) {
        delegate?.actionClickCardView(indexPath: sender.indexPath!)
    }

    class myTapCustom: UITapGestureRecognizer {

        var indexPath: IndexPath?

    }
    
    
}
