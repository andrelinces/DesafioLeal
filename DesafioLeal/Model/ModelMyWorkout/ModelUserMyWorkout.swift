//
//  ModelUserMyWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 10/04/22.
//

import UIKit

protocol ModelUserMyWorkoutCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
}

class ModelUserMyWorkout: tableViewCompatible {
    internal init(delegate: ModelUserMyWorkoutCellCallBack? = nil, navigationController : UINavigationController?, nameWorkout: String, dateWorkout: String, descriptionWorkout: String) {
        
        self.delegate = delegate
        //self.imageWorkout = imageWorkout
        //self.titleMyWorkout = titleMyWorkout
        self.nameWorkout = nameWorkout
        self.dateWorkout = dateWorkout
        self.descriptionWorkout = descriptionWorkout
        
        
    }
    
    var reuseIdentifier: String {
        
        "ModelUserMyWorkoutCellIdentifier"
        
    }
   
    open weak var delegate : ModelUserMyWorkoutCellCallBack?


    //var imageWorkout: String
    //var titleMyWorkout: String
    var nameWorkout: String
    var dateWorkout: String
    var descriptionWorkout: String
    
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelUserMyWorkoutCell {
        
            
            cell.setupView()
            cell.setupDesign()
            cell.setupValues(nameWorkout: nameWorkout, dateWorkout : dateWorkout, descriptionWorkout: descriptionWorkout )
            //cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //Adding clicks in card from tableview
            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
            gestureClickCard.indexPath = indexpath
            
            cell.cardViewMyWorkout.addGestureRecognizer(gestureClickCard)
            
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
