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
        self.tabBarController?.selectedIndex = 1
    }
   
    func actionClickCardView(indexPath: IndexPath) {
        print("click in card!!\(indexPath)")
        
        if indexPath.row == 1 {
 
            performSegue(withIdentifier: "segueMyWorkout" , sender: nil)
        }
            
    }
 
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //testWorkout()
        print("test appear home")
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
                dataSource.navigationController = nil
        
        print("Teste voltar : \(navigationController)")
        
    }//[end didAppear]

    
    func diplayUserWorkout () {
       
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
        let userId = auth.currentUser?.uid
            if user?.isAnonymous == true {
                
                print("user anonymous? \(user)")
            }
            
            //[error user dont logged!!]
            let worRef =  self.db.collection("users").document(userId ?? "userdontlogged").collection("workout")
            
            
        print("userID \(userId)")
            worRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("funcWorkout\(document.documentID) => \(document.data())")
                    //print("Error getting documents: \(worRef)")
                    
                   
                        var workoutUser : userWorkout? = nil
                    
                        
                        do {
                            workoutUser = try document.data(as: userWorkout.self)
                            print("workout id testW... \(workoutUser?.name)")
                            
                            for listWorkout in workoutUser!.idWorkout {
                            
                            let cardWorkout = ModelWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: self.imageWorkout, myWorkout: workoutUser!.name )
                            self.dataSource.navigationController = self.navigationController
                            self.dataSource.data.append(cardWorkout)
                            
                            self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                            
                            self.tableViewWorkout.allowsSelection = false
                            
                            self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                            
                            self.tableViewWorkout.reloadData()
                            }
                            
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
                    
                    break
                }
                }
            
        }//[end get workout]

        }
    }
        
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionReturn()
        diplayUserWorkout()
       
        setupTableView()
    }
    
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
    
    func setupTableView () {
        
        dataSource.navigationController = self.navigationController
        
     //[Image and title view workout]
        let cardWorkoutPoster = ModelWorkoutPoster(delegate: self, navigationController: self.navigationController, imagePosterWorkout: imagePosterWorkout, titleWorkout: "titleWorkout", descriptionWorkout: descriptionWorkout )
        
       
        dataSource.data.append(cardWorkoutPoster)
        
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                
    }
    
  

}

