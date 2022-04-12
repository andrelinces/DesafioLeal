//
//  ModelTitleMyWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

protocol ModelTitleMyWorkoutCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
    
    func actionReturn ()
    
}

class ModelTitleMyWorkout: tableViewCompatible {
    internal init(delegate: ModelTitleMyWorkoutCellCallBack? = nil, navigationController : UINavigationController?, imageWorkout: String, titleMyWorkout: String) {
        
        self.delegate = delegate
        self.imageWorkout = imageWorkout
        self.titleMyWorkout = titleMyWorkout
    }
    
    var reuseIdentifier: String {
        
        "ModelTitleMyWorkoutCellIdentifier"
        
    }
   
    open weak var delegate : ModelTitleMyWorkoutCellCallBack?


    var imageWorkout: String
    var titleMyWorkout: String
    
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelTitleMyWorkoutCell {
        
            
            //cell.setupView()
            cell.setupDesign()
            cell.setupValues(titleMyWorkout: titleMyWorkout)
            //cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //Adding clicks in card from tableview
            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
            gestureClickCard.indexPath = indexpath
            
            cell.cardViewTitle.addGestureRecognizer(gestureClickCard)
            
            //MARK: Return button action on movie details screen, this method is used in main view..
            cell.buttonReturn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionReturn)))
            cell.cornerViewButtonReturn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertAdd)))
            
            
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
    
    //Function of the return button, used into main view.
    @objc func actionReturn(sender : UITapGestureRecognizer){
        
        delegate?.actionReturn()
    }
    
    @objc func alertAdd () {
        
        // [Alert for to user, account created successfully]
        let alert = UIAlertController(title:  "Menu Workout", message: "Do your want to editing your workout ?", preferredStyle: .alert)
       
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
            //testing...
            print("confirmAction")
//                self.performSegue(withIdentifier: "segueUserWorkout", sender: nil)
            //self.performSegue(withIdentifier: "segueMyWorkout", sender: inde)
        }
        
        
    }
}


