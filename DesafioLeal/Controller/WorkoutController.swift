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
import SwiftUI

class WorkoutController: UIViewController, ModelExercisesPosterCallBack, ModelWorkoutPosterCellCallBack, ModelWorkoutCellCallBack, ModelTitleMyWorkoutCellCallBack {
    
    func actionReturn() {
        print("Teste voltar : \(tabBarController)")
        navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 0
    }
   
    func actionClickCardView(indexPath: IndexPath) {
        print("click in card, WorkoutController!!\(indexPath)")
        
        if indexPath.row > -1  {
            
            
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Menu Workout", message: "what do you want to do ? ?", preferredStyle: .alert)
           
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
            let confirmAction = UIAlertAction(title: "To edit", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            
                self.performSegue(withIdentifier: "segueMyWorkout" , sender: nil)
        }
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
 
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    //Variables inicialization
    var imagePosterWorkout : String = ""
    var titleWorkout : String = ""
    var imageWorkout : String = ""
    var myWorkout : String = ""
    var descriptionWorkout : String = " "
    
    func initiate(imagePosterWorkout : String, titleWorkout : String,  descriptionWorkout: String){
        self.imagePosterWorkout = imagePosterWorkout
        self.titleWorkout = titleWorkout
        self.descriptionWorkout = descriptionWorkout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //diplayUserWorkout ()
     
        
    }//[end didAppear]

    
    func diplayUserWorkout () {
       
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
        let userId = auth.currentUser?.uid
            print("user anonymous? \(String(describing: user?.uid))")
            
            if userId == nil {
                
                //[User dont logged our dont exists!]
                print("Error getting documents: \(String(describing: userId))")
                
            }else{
            
                let worRef =  self.db.collection("users").document(userId ?? "default Card").collection("workout")
                        let idwork = worRef.document().documentID
                        print("Id workout, WorkoutController\(String(describing: userId))")
                    
                    //users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/QrDLFWTR3QP0aUFZgjJu/myexercises
                    
                    print("userID \(String(describing: (worRef)))")
                    
                    worRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        
                    } else {
                        
                        for document in querySnapshot!.documents {
                            print("funcDysplay\(document.documentID) => \(document.data())")
                            //print("Error getting documents: \(worRef)")
                            print("funcDysplay : \(document.data().description)")
                            
                            
                                var workoutUser : userWorkout? = nil
                                
                            print("nameWork1 workout controller\(workoutUser?.idWorkout)")
                            do {
                            
                                workoutUser = try document.data(as: userWorkout.self)
                            }catch {
                                
                                print("Error getting documents: \(workoutUser)")
                            }
                            print("Error getting documents: \(workoutUser?.name)")
                            let cardWorkout = ModelWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: self.imageWorkout, myWorkout: workoutUser?.name ?? "Default" )
                           
                            
                            self.dataSource.data.append(cardWorkout)
                            
                            self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                            
                            self.tableViewWorkout.allowsSelection = false
                            
                            self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                            
                            self.tableViewWorkout.reloadData()
                  
                    }
                        
                    }//[end get workout]
                    
                    
                }
                
            }
        }
    }
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //actionReturn()
        diplayUserWorkout()
        
        setupTableView()
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    func setupTableView () {
        
        dataSource.navigationController = self.navigationController
        
     //[Image and title view workout]
        let cardWorkoutPoster = ModelWorkoutPoster(delegate: self, navigationController: self.navigationController, imagePosterWorkout: imagePosterWorkout, titleWorkout: titleWorkout, descriptionWorkout: descriptionWorkout )
        
        let cardWorkout = ModelWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: self.imageWorkout, myWorkout: "Default" ?? "Default" )
       
        dataSource.data.append(cardWorkoutPoster)
      
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                 
    }
    
}




