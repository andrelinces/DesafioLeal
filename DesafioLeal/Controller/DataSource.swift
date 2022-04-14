//
//  DataSource.swift
//  DesafioLeal
//
//  Created by Andre Linces on 31/03/22.
//


import UIKit

class DataSource: NSObject {

var data = [Any] ()
var navigationController: UINavigationController?
var titleExercises = ""

func initializeTableView(tableView: UITableView){
    
    tableView.dataSource = self
    tableView.delegate = self
    
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.alpha = 0
    navigationController?.navigationBar.backItem?.title = "Back"
    
    //Registing the cells
    tableView.register(UINib(nibName: "ModelExercisesTitleCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelExercisesTitleCellIdentifier")
    tableView.register(UINib(nibName: "ModelExercisesPosterCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelExercisesPosterCellIdentifier")
    tableView.register(UINib(nibName: "ModelWorkoutPosterCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelWorkoutPosterCellIdentifier")
    tableView.register(UINib(nibName: "ModelWorkoutCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelWorkoutCellIdentifier")
    tableView.register(UINib(nibName: "ModelTitleMyWorkoutCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelTitleMyWorkoutCellIdentifier")
    tableView.register(UINib(nibName: "ModelMyWorkoutCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelMyWorkoutCellIdentifier")
    tableView.register(UINib(nibName: "ModelUserMyWorkoutCell", bundle: Bundle.main), forCellReuseIdentifier: "ModelUserMyWorkoutCellIdentifier")
      
}
}

extension DataSource: UITableViewDataSource, UITableViewDelegate {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let modelCardExercisesPoster = data[indexPath.row] as? ModelExercisesPoster {
        
        return modelCardExercisesPoster.cellForTableView(tableView: tableView, atIndexpath: indexPath)
        
    }else if let modelCardExercisesTitle = data[indexPath.row] as? ModelExercisesTitle{

        return modelCardExercisesTitle.cellForTableView(tableView: tableView, atIndexpath: indexPath)

    }else if let modeWorkoutTitle = data[indexPath.row] as? ModelWorkoutPoster{

        return modeWorkoutTitle.cellForTableView(tableView: tableView, atIndexpath: indexPath)
     
    }else if let ModelWorkoutCell = data[indexPath.row] as? ModelWorkout{

        return ModelWorkoutCell.cellForTableView(tableView: tableView, atIndexpath: indexPath)
        
    }else if let ModelTitleMyWorkoutCell = data[indexPath.row] as? ModelTitleMyWorkout{

        return ModelTitleMyWorkoutCell.cellForTableView(tableView: tableView, atIndexpath: indexPath)
        
    }else if let ModelMyWorkoutCell = data[indexPath.row] as? ModelMyWorkout{

        return ModelMyWorkoutCell.cellForTableView(tableView: tableView, atIndexpath: indexPath)
        
    }else if let ModelUserMyWorkoutCell = data[indexPath.row] as? ModelUserMyWorkout{

        return ModelUserMyWorkoutCell.cellForTableView(tableView: tableView, atIndexpath: indexPath)
        
    }else{
        
        
        return UITableViewCell()
        
    }
}

//funciton for scrollview when the user scroll the list, show navigation bar
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    //Print for tests and to display the position of the scroll, the initial position is -44
    print("Scroll contentOffset: \(scrollView.contentOffset.y)")
    
    if navigationController != nil {
        if scrollView.contentOffset.y > 30 {//MARK: Displays navigation bar when the down scroll.

            navigationController?.navigationBar.alpha = scrollView.contentOffset.y / 180
            navigationController?.navigationBar.tintColor = .darkGray
            navigationController?.navigationBar.backgroundColor = .gray
        }else{
            navigationController?.navigationBar.alpha = 0

        }

        if scrollView.contentOffset.y > 304 {//MARK: When the navigation bar to hide title of the movie, It's diplay title from movie in the navigation bar.
            navigationController?.navigationBar.topItem?.title = titleExercises
        }else {
            navigationController?.navigationBar.topItem?.title = "Exercises"
        }
    }

}

}

