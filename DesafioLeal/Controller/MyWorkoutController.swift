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
        
    }
    
    
    func actionClickCardView(indexPath: IndexPath) {
        print("clicou no card\(indexPath.item)")
        
//        if indexPath.row == 1 {
            
                // [Alert for to user, account created successfully]
                let alert = UIAlertController(title:  "Menu Workout", message: "what do you want to do ? ?", preferredStyle: .alert)
               
                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
                let delete = UIAlertAction(title: "Delete", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                    
                    //MARK: --
                    
                    self.handle = Auth.auth().addStateDidChangeListener { auth, user in
                        
                    let userId = auth.currentUser?.uid
                        
                        let worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
                        
                        
                    print("userID \(userId)")
                        worRef.getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                            
                        } else {
                            for document in querySnapshot!.documents {
                                print("funcWorkout\(document.documentID) => \(document.data())")
                               
                                    var workoutUser : userWorkout? = nil
                                
                                    do {
                                        workoutUser = try document.data(as: userWorkout.self)
                                        print("workout id testW... \(workoutUser?.name)")
                                    }catch {
                                        
                                        print("error listCollection \(err)")
                                    }
                                
                                break
                            
                            }
                        
                    }
                    //MARK: -- [get data User workout]
                        
                    worRef.getDocuments() { (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                switch document.documentID != nil {
                 
                  
                                case true :
                                    
                                    var workoutUser : userWorkout? = nil
                                    
                                    
                                    do {
                                        workoutUser = try document.data(as: userWorkout.self)
                                        print("workout idtestW... \(workoutUser?.name)")
                                        let idWor = workoutUser?.idWorkout
                                        //let exerRef = worRef(idWor).collection("myexercises")
                                        
                                    let newTest =  worRef.document(idWor!).collection("myexercises")
                                            newTest.getDocuments() { (querySnapshot, err) in
                                        
                                                
                                            if let err = err {
                                                print("Error getting documents: \(err)")
                                            } else {
                                                print("funcTestRef Else...\(idWor)")
                                                
                                                for document in querySnapshot!.documents {
                                                    print("funcTestRef For...")
                                                    switch document.documentID != nil {
                                     
                                                    case true :
                                                        var userExercises : userWorkoutExercises? = nil
                                                        print("funcExer1\(document.documentID) => \(document.data())")
                                                        print("test for exer")
                                                    //[to recover user exercises]
                                                    do {
                                                        userExercises = try document.data(as: userWorkoutExercises.self)
                                                        print("funcExer2\(document.documentID) => \(document.data())")
                                                        print("workoutExerc... \(userExercises!.idExercises)")
                                                    //MARK: -- Corrected display error of user training exercises table.
                                                        
                                                        for listExercises in querySnapshot!.documents {
                                                            print("listexercises \(listExercises.documentID)")
                                                            
                                                            let list = listExercises.documentID
                                                            
           //                                                 if listExercises.documentID .contains(userExercises!.idExercises) {
                                                            //for listExercisesUser in list {
                                                                
                                                            do { listExercises.documentID .contains(userExercises!.idExercises)
                                                               
                                                                
                                                                //MARK: -- //delete exercises
                                                                newTest.document(userExercises!.idExercises).delete() { err in
                                                                    if let err = err {
                                                                        print("Error removing document: \(err)")
                                                                    } else {
                                                                        print("Document successfully removed!")
                                                                        
                                                                        // [Alert for to user, account created successfully]
                                                                        let alert = UIAlertController(title:  "Welcome \(userExercises!.name)!", message: " Exercises delete Successfully!! ", preferredStyle: .alert)
                                                                       
                                                                        
                                                                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                                            //testing...
                                                                            print("confirmAction")
                                                                            self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
                                                                            self.tableViewWorkout.reloadData()
                                                                            
                                                                        }
                                                                   
                                                                        alert.addAction(confirmAction)
                                                                        
                                                                        self.present(alert, animated: true, completion: nil)
                                                                        
                                                                        
                                                                        self.tableViewWorkout.reloadData()
                                                                    }
                                                                }//[END Delete exercises]

                                                        self.tableViewWorkout.reloadData()
                                                            //}
                                                        }
                                                        }
                                                        print("userExercises \(userExercises!.imageurl)")
                                                    }catch {
                                                        
                                                        print("userExercises \(userExercises?.imageurl)")
                                                        print("error listCollection \(err)")
                                                    }
                                                        
                                                    case false :
                                                        break
                                                        
                                                    }
                                                
                                                }
                                                }
                                        }
                                        
                                    }catch {
                                        
                                        print("error listCollection \(err)")
                                    }
                                    //checking cell created my workout
                                    let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameMyWorkout: self.nameWorkout, descriptionMyWorkout: self.descriptionWorkout)
                                    
                                    let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser!.name )
                                    
                                    self.dataSource.data.append(cardTitleMyWorkout)
                                    
                                    self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                                    
                                    self.tableViewWorkout.allowsSelection = false
                                    
                                    self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                                    
                                    self.tableViewWorkout.reloadData()
                                    
                                    print("workout2 idtestW... \(workoutUser?.idWorkout)")
                                case false :
                                    
                                    break
                                }
                    
                            }
                           }
                           }
                    }//[listener handle]
                           
               }
               
            }
                
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                    //testing...
                    print("confirmAction")
                    //self.performSegue(withIdentifier: "segueUserUpadate", sender: nil)
                }
    
                alert.addAction(delete)
                alert.addAction(cancelAlert)
                alert.addAction(confirmAction)
                
                self.present(alert, animated: true, completion: nil)
              
           // }
    }//[end if actionclickcard]
    
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
   
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    //@IBOutlet weak var tableViewMyWorkout: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      testTableView()
        //setupTableView ()
        //self.tableViewMyWorkout.reloadData()
        //singIn()
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
//
//            }
              
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
    
func testTableView () {
    
    
    //dataSource.data.removeAll()
     handle = Auth.auth().addStateDidChangeListener { auth, user in
         
     let userId = auth.currentUser?.uid
         
         let worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
         
         
     print("userID \(userId)")
         worRef.getDocuments() { (querySnapshot, err) in
         if let err = err {
             print("Error getting documents: \(err)")
             
         } else {
             for document in querySnapshot!.documents {
                 print("funcWorkout\(document.documentID) => \(document.data())")
                
                     var workoutUser : userWorkout? = nil
                 
                     do {
                         workoutUser = try document.data(as: userWorkout.self)
                         print("workout id testW... \(workoutUser?.name)")
                         
                         
                         let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser!.name )
                         
                         
                         
                         self.dataSource.data.append(cardTitleMyWorkout)
                         
                         self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                         
                         self.tableViewWorkout.allowsSelection = false
                         
                         self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                         
                         self.tableViewWorkout.reloadData()
                         
                         var workoutUser : userWorkout? = nil
                         
                         
                         do {
                             workoutUser = try document.data(as: userWorkout.self)
                             print("workout idtestW... \(workoutUser?.name)")
                             let idWor = workoutUser?.idWorkout
                             //let exerRef = worRef(idWor).collection("myexercises")
                             
                         let newTest =  worRef.document(idWor!).collection("myexercises")
                                 newTest.getDocuments() { (querySnapshot, err) in
                                     
                                     for document in querySnapshot!.documents {
                                     
                                     var userExercises : userWorkoutExercises? = nil
                                        
                                         do {
                                             userExercises = try document.data(as: userWorkoutExercises.self)
                                             print("workout id testW... \(workoutUser?.idWorkout)")
                                               
                                         }catch {
                                             
                                             print("error listCollection \(err)")
                                         }
                                    
                                         let cardExercisesWorkout = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: "musculacao", exercisesTitle: userExercises!.name, observation: userExercises!.description)

                                         self.dataSource.data.append(cardExercisesWorkout)

                                         self.dataSource.initializeTableView(tableView: self.tableViewWorkout)

                                         self.tableViewWorkout.allowsSelection = false

                                         self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none

                                         self.tableViewWorkout.reloadData()
                                         
                                     }
                                 }
                                 }
                         
                     }catch {
                         
                         print("error listCollection \(err)")
                     }
                 
                 break
             }
         }
             
         }
        
         
         
     }
}
}//[end class]
