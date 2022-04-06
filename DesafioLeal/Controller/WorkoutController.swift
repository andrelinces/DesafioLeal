//
//  TrainingController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 31/03/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class WorkoutController: UIViewController, ModelExercisesPosterCallBack, ModelWorkoutPosterCellCallBack {
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    //var auth = Auth.auth().currentUser?.uid
    
    var db = Firestore.firestore()
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("test workoutcontroller...")
        
        
        setupTableView()
    }
    
    //Variables inicialization
    var imagePosterWorkout : String = ""
    var titleWorkout : String = ""
    
    
    func initiate(imagePosterWorkout : String, exercisesTitle : String, observation : String){
        self.imagePosterWorkout = imagePosterWorkout
        
        
        //self.urlDetails = urlDetails
    }
    
    func setupTableView () {
        
        //dataSource.data = [Any]()
        
        let cardWorkoutPoster = ModelWorkoutPoster(delegate: self, navigationController: self.navigationController, imagePosterWorkout: imagePosterWorkout, titleWorkout: "Test Workout" )
        
        dataSource.data.append(cardWorkoutPoster)
        
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                
    }
    
    
    func newTraining () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
        
            let uid = user.uid
        //}
       
            let db = db.collection("Users").document(uid)
                .collection("NameChoiceUser2").document("NameChoiceUser2").setData(["Exercicies 1" : "NameChoiceUser2"]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
        print("test func newTraining...\(db)")
    }
    }

    func singIn () {
        
        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
        }
    }
    

}
