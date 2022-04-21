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
            
            alertEditWorkout()
        
            self.tableViewWorkout.reloadData()
            
        }
        
    }//[end indexPaath]
 
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    var auth = Auth.auth()
    
    //Variables inicialization
    var imagePosterWorkout : String = ""
    var titleWorkout : String = " "
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
    
    func alertEditWorkout () {
        
            let alertEdit = UIAlertController(title: "To edit!", message: "Do you want to edit your workout?", preferredStyle: .alert)
            
            let confirmEdit = UIAlertAction(title: "To edit", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                
                self.performSegue(withIdentifier: "segueMyWorkout", sender: nil)
                })
            
            let confirmUpdate = UIAlertAction(title: "Update name", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                
                // Create Update alert controller
                    let alertController = UIAlertController(title: "Update Name", message: "Type name for to workout!", preferredStyle: .alert)

                    // add textfield at index 0
                    alertController.addTextField(configurationHandler: {(_ textFieldName: UITextField) -> Void in
                        textFieldName.placeholder = "Name"
                        self.present(alertController, animated: true, completion: nil)
       
                                let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                
                                    self.myWorkout = alertController.textFields?[0].text ?? "default test field"
                                    
                                    var handle: AuthStateDidChangeListenerHandle?
                                    
                                    if alertController.textFields?[0].text == "" {

                                        let alert = UIAlertController(title: "Empty field", message: "Type name or categorie for to workout!", preferredStyle: .alert)

                                        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                            print("Canelled")
                                            
                                        })
                                        alert.addAction(cancel)
                                        self.present(alert, animated: true, completion: nil)
                
                                    }else{
                                        
                                    let userId = self.auth.currentUser?.uid
                                    var refNewName = self.db.collection("users").document(userId ?? "default").collection("workout").document(userId ?? "default")
                                    
                                    // Set the reference for to updating document.
                                        refNewName.updateData ([
                                        
                                        "name": alertController.textFields?[0].text
                                        
                                    ])
                                        { err in
                                        if let err = err {
                                            print("Error updating document: \(err)")
                                        } else {
                                            self.tableViewWorkout.reloadData()
                                            print("Document successfully updated")
                                            
                                            let alertUpdate = UIAlertController(title: "Update Document Successfully!", message: "Updated Document  successfully, click a edit, for to display all information from workout and add exercises.", preferredStyle: .alert)

                                            let okUpdate = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                                print("okUpadte")
                                                
                                                    self.tableViewWorkout.reloadData()
                                                    print("async, tableview")
                                                   
                                                self.presentedViewController?.reloadInputViews()
                                            })
                                            alertUpdate.addAction(okUpdate)
                                            self.present(alertUpdate, animated: true, completion: nil)
                                            
                                        }
                                        
                                    }
                                   
                                    }//[end else]
                                    alertEdit.addAction(confirmEdit)
                                    
                                })
 
                                alertController.addAction(confirmAction)
    
                    })
               
                })
            self.tableViewWorkout.reloadData()
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
              
                })
           
                alertEdit.addAction(confirmEdit)
                alertEdit.addAction(confirmUpdate)
                alertEdit.addAction(cancel)
           
                self.present(alertEdit, animated: true, completion: nil)
            
            // Create Update alert controller
                let alertController = UIAlertController(title: "Update Name", message: "Type name for to workout!", preferredStyle: .alert)

                // Alert action cancel
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                    print("Canelled")
                
                })
                alertController.addAction(cancelAction)
            
                // Present alert controller
                present(alertController, animated: true, completion: nil)
                self.tableViewWorkout.reloadData()
        
        
        
    }//[End alertEditWorkout]
    
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
                    
                    print("userID \(String(describing: (worRef)))")
                    
                worRef.getDocuments { (querySnapshot, err) in
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
        let cardWorkoutPoster = ModelWorkoutPoster(delegate: self, navigationController: self.navigationController, imagePosterWorkout: imagePosterWorkout, titleWorkout: "Workout", descriptionWorkout: descriptionWorkout )
        
        let cardWorkout = ModelWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: self.imageWorkout, myWorkout: "Default" ?? "Default" )
       
        dataSource.data.append(cardWorkoutPoster)
      
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                 
    }
    
}




