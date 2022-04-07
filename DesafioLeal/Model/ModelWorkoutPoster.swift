//
//  ModelWorkoutPoster.swift
//  DesafioLeal
//
//  Created by Andre Linces on 05/04/22.
//

import UIKit

protocol ModelWorkoutPosterCellCallBack: class {
    
    
    
}

class ModelWorkoutPoster: tableViewCompatible {
    internal init (delegate: ModelWorkoutPosterCellCallBack?, navigationController : UINavigationController?, imagePosterWorkout: String, titleWorkout: String){
            self.delegate = delegate
            self.imagePosterWorkout = imagePosterWorkout
            self.titleWorkout = titleWorkout
        
}

open weak var delegate: ModelWorkoutPosterCellCallBack?

var reuseIdentifier: String {
    
    return "ModelWorkoutPosterCellIdentifier"
}

var imagePosterWorkout: String
var titleWorkout: String


func cellForTableView(tableView: UITableView, atIndexpath indexpath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexpath) as? ModelWorkoutPosterCell {
    
        
        //cell.setupView()
        //cell.setupDesign()
        //cell.setupValues(imagePosterWorkout: imagePosterWorkout)
        cell.setupImage(imagePosterWorkout: imagePosterWorkout, titleWorkout: titleWorkout)
        
        return cell
        
        
    }else{
        
        return UITableViewCell()
        
    }
}

}
