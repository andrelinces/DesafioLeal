//
//  ModelWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 06/04/22.
//

import UIKit

protocol ModelWorkoutCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
    
}
class ModelWorkout: tableViewCompatible{
    internal init(delegate: ModelWorkoutPosterCellCallBack? = nil, navigationController : UINavigationController?, imageWorkout: String, myWorkout: String) {
        self.delegate = delegate
        self.imageWorkout = imageWorkout
        self.myWorkout = myWorkout
    }
    
    
    
    open weak var delegate: ModelWorkoutPosterCellCallBack?
    
    var reuseIdentifier: String {
        
        "ModelWorkoutCellIdentifier"
    }
    //Variables initialization
    var imageWorkout: String
    var myWorkout: String
    
    func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelWorkoutCell {
        
            
            cell.setupView()
            cell.setupDesign()
            //cell.setupValues(imagePosterWorkout: imagePosterWorkout)
            cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //Adding clicks in card from tableview
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
