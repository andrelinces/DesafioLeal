//
//  ModelTitleMyWorkout.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit

protocol ModelTitleMyWorkoutCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
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
            //cell.setupDesign()
            cell.setupValues(titleMyWorkout: titleMyWorkout)
            //cell.setupImage(imageWorkout: imageWorkout, myWorkout: myWorkout)
            
            //Adding clicks in card from tableview
            let gestureClickCard = myTapCustom(target: self, action: #selector(actionClickCardView))
            gestureClickCard.indexPath = indexpath
            
            cell.cardViewTitle.addGestureRecognizer(gestureClickCard)
            
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


