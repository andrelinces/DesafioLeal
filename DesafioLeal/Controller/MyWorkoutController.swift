//
//  MyWorkoutController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class MyWorkoutController: UIViewController, ModelTitleMyWorkoutCellCallBack, ModelMyWorkoutCellCallBack, ModelUserMyWorkoutCellCallBack, ModelExercisesPosterCallBack {
    
    func actionReturn() {
        print("Teste voltar, Myworkout : \(tabBarController)")
        navigationController?.popViewController(animated: true)
        
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func buttonMyWorkout(_ sender: Any) {
        
        print("ButtonMyWorkout..")
            performSegue(withIdentifier: "segueMyWorkoutWorkout", sender: nil)
    }
    
    
    func actionClickCardView(indexPath: IndexPath) {
        print("click card MyWorkoutController\(indexPath.item)")
        
        // [Alert for to user, account created successfully]
        let alert = UIAlertController(title:  "Menu Workout", message: "what do you want to do ? ?", preferredStyle: .alert)
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let delete = UIAlertAction(title: "Delete", style: .default) { alertAction in
            //testing...
            print("AlertDelete")
            print("indexpath cell \(indexPath.item)")
            
            self.deleteExercises()
            self.tableViewWorkout.reloadData()
             
        }
        
        let Update = UIAlertAction(title: "Update", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            //self.performSegue(withIdentifier: "segueUserUpadate", sender: nil)
        }
        
        alert.addAction(delete)
        alert.addAction(cancelAlert)
        alert.addAction(Update)
        
        self.present(alert, animated: true, completion: nil)
     
    }//[end if actionclickcard]
    
     
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
   
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewWorkout: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupTableView ()
        tableViewWorkout.reloadData()
   
        //deleteExercises2()
    }
  
    
    var nameTitleMyWorkout :  String = ""
    var nameMyWorkout : String = ""
    var descriptionMyWorkout :  String = ""
    
    //[variables class ModelUserMyWorkoutCell]
    var nameWorkout: String = ""
    var dateWorkout: String = ""
    var descriptionWorkout: String = ""
    
    func initiate(nameMyWorkout: String, descriptionMyWorkout: String, nameTitleMyWorkout: String, nameWorkout: String  ){
        
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
        self.nameTitleMyWorkout = nameTitleMyWorkout
        self.nameWorkout = nameWorkout
        
    }
    
    @IBAction func menuButton(_ sender: Any) {
        
        //newWorkout()
        // [Alert for to user, account created successfully]
        let alert = UIAlertController(title:  "Menu Workout", message: "Do your want to add exercises your workout ?", preferredStyle: .alert)
        
        let addExercisesAlert = UIAlertAction(title: "Add exercises?", style: (.init(rawValue: 6) ?? .default)) { alertAction in
 
               self.performSegue(withIdentifier: "segueNewExercisesMyWorkout", sender: nil)
    
        }
        let addWorkoutAlert = UIAlertAction(title: "Add Workout?", style: (.init(rawValue: 6) ?? .default)) { alertAction in

            self.performSegue(withIdentifier: "segueNewWorkoutMyWorkout", sender: nil)
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            self.performSegue(withIdentifier: "segueNewExercisesMyWorkout", sender: nil)
               
        }
        
        alert.addAction(addExercisesAlert)
        alert.addAction(addWorkoutAlert)
        alert.addAction(cancelAlert)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
          
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        
      
        self.performSegue(withIdentifier: "segueWorkoutHome", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }

    func setupTableView () {
        
        
        //dataSource.data.removeAll()
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            var worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
            
            
            print("userID \(userId)")
            worRef.getDocuments() { (querySnapshot, err) in
                if userId == nil {
                    print("Error getting documents: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        print("funcWSetupTableMyWorkout\(document.documentID) => \(document.data())")
                        
                        var workoutUser : userWorkout? = nil
                        
                        do {
                            workoutUser = try document.data(as: userWorkout.self)
                            print("workout id testW... \(workoutUser?.name)")
                            
                            
                            let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser?.name ?? "Default" )
                            
                            self.dataSource.data.append(cardTitleMyWorkout)
                            
                            self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                            
                            self.tableViewWorkout.allowsSelection = false
                            
                            self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                            
                            self.tableViewWorkout.reloadData()
                            //self.testGetExer()
                            
                        }catch {
                            print("error listCollectionMYWorkoutController \(err)")
                        }
                        //testing here.....
                      
                    }//[END for]
                    
                    var exerRef = worRef.document(userId ?? "default").collection("myexercises")
                    
                    exerRef.getDocuments() { (querySnapshot, err) in
                        
                        for document in querySnapshot!.documents {
                            
                            var userExercises : userWorkoutExercises? = nil
                            
                            do {
                                userExercises = try document.data(as: userWorkoutExercises.self)
                                print("ExercisesMyWork id testW... \(String(describing: userExercises?.idExercises))")
                                
                            }catch {
                                
                                print("error listCollectionMYWorkoutController \(err)")
                            }
                            print("error listCollectionMYWorkoutController \(userExercises?.name)")
                            
                            let cardExercisesWorkout = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: "musculacao", exercisesTitle: userExercises?.name ?? "default name", observation: userExercises?.description ?? "default")
                            
                            self.dataSource.data.append(cardExercisesWorkout)
                            
                            self.tableViewWorkout.reloadData()
                        }
                        
                    }
                    
                }
            }
                
        }
    }
             
    func deleteExercises() {
        
        //dataSource.data.removeAll()
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            var worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
            
            print("userID \(userId)")
            worRef.getDocuments() { (querySnapshot, err) in
                if userId == nil {
                    print("Error getting documents: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        print("funcWSetupTableMyWorkout\(document.documentID) => \(document.data())")
                        
                        var workoutUser : userWorkout? = nil
                        
                        do {
                            workoutUser = try document.data(as: userWorkout.self)
                            print("workout id testW... \(workoutUser?.name)")
                            
                        }catch {
                            print("error listCollectionMYWorkoutController \(err)")
                        }
                        //testing here.....
                        
                        var exerRef = worRef.document(userId ?? "default").collection("myexercises")
                        
                        exerRef.getDocuments() { (querySnapshot, err) in
                            
                            for document in querySnapshot!.documents {
                                
                                var userExercises : userWorkoutExercises? = nil
                                
                                do {
                                    userExercises = try document.data(as: userWorkoutExercises.self)
                                    print("ExercisesMyWork id testW... \(String(describing: userExercises?.idExercises))")
                                    
                                }catch {
                                    
                                    print("error listCollectionMYWorkoutController \(err)")
                                }
                                print("Succes... listCollectionMYWorkoutController \(userExercises?.name)")
                                
                                // i
                                var listExercises = document.documentID
                                
                                var idWork = workoutUser?.idWorkout
                                
                                self.db.collection("users").document(userId ?? "error").collection("workout").document(idWork ?? "default").collection("myexercises").document(userExercises?.idExercises ?? "defaul").delete() { err in
                                    if let err = err {
                                        self.tableViewWorkout.reloadData()
                                        self.viewDidLoad()
                                        print("Error removing document: \(String(describing: userExercises?.name)), error: \(err)")
                                        
                                        // [Alert for to user, account created successfully]
                                        let alert = UIAlertController(title:  "Delete Exercises!", message: " Error removing document!! ", preferredStyle: .alert)
                                        
                                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                            //testing...
                                            print("confirmAction")
                                            //  self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
                                            
                                            self.tableViewWorkout.reloadData()
                                            self.viewDidLoad()
                                        }
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        alert.addAction(confirmAction)
                                        
                                    } else {
                                        self.tableViewWorkout.reloadData()
                                        print("Document successfully removed\(String(describing: userExercises?.name))!")
                                        
                                        // [Alert for to user, account created successfully]
                                        let alert = UIAlertController(title:  "Delete Exercises!", message: " Exercises delete Successfully!! ", preferredStyle: .alert)
                                        
                                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                            //testing...
                                            print("confirmAction")
                                            //  self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
                                            self.dismiss(animated: true, completion: nil)
                                            self.tableViewWorkout.reloadData()
                                        }
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        alert.addAction(confirmAction)
                                        
                                    }
                                      
                                }
                                   
                            }//[END for exercises]
                        }
                        
                    }//[END for workout]
                }
            }
        }
        
    }
    
}//[end class]



