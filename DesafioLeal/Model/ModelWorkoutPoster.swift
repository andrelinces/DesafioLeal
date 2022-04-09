//
//  ModelWorkoutPoster.swift
//  DesafioLeal
//
//  Created by Andre Linces on 05/04/22.
//

import UIKit

protocol ModelWorkoutPosterCellCallBack: class {
    
    func actionClickCardView (indexPath: IndexPath)
    
}

class ModelWorkoutPoster: tableViewCompatible {
    internal init (delegate: ModelWorkoutPosterCellCallBack?, navigationController : UINavigationController?, imagePosterWorkout: String, titleWorkout: String, descriptionWorkout: String){
            self.delegate = delegate
            self.imagePosterWorkout = imagePosterWorkout
            self.titleWorkout = titleWorkout
            self.descriptionWorkout = descriptionWorkout
        
}

open weak var delegate: ModelWorkoutPosterCellCallBack?

var reuseIdentifier: String {
    
    return "ModelWorkoutPosterCellIdentifier"
}

var imagePosterWorkout: String
var titleWorkout: String 
var descriptionWorkout : String


func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelWorkoutPosterCell {
    
        
        //cell.setupView()
        //cell.setupDesign()
        cell.setupValues( descriptionWorkout: descriptionWorkout)
        cell.setupImage(imagePosterWorkout: imagePosterWorkout, titleWorkout: titleWorkout)
        
        return cell
        
        
    }else{
        
        return UITableViewCell()
        
    }
}

}
