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
    
    func actionClickCardView(indexPath: IndexPath) {
        print("clicou no card\(indexPath.item)")
        
        if indexPath.row == 1 {
            
            
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Menu Workout", message: "Select choice: !!", preferredStyle: .alert)
            
            let addAlert = UIAlertAction(title: "Add New Workout", style: (.init(rawValue: 3) ?? .default)) { alertAction in
                print( "testAlert workout")
                //let addAlert = UIAlert
                //self.performSegue(withIdentifier: "segueUserUpadate", sender: nil)
            }
            let updateAlert = UIAlertAction(title: "update your Workout?", style: (.init(rawValue: 3) ?? .default)) { alertAction in
                print( "testAlert workout")
                //let addAlert = UIAlert
                //self.performSegue(withIdentifier: "segueUserUpadate", sender: nil)
            }
            let deleteteAlert = UIAlertAction(title: "update your Workout?", style: (.init(rawValue: 3) ?? .default)) { alertAction in
                print( "testAlert workout")
                //let addAlert = UIAlert
               // self.performSegue(withIdentifier: "segueUserMyWorkout", sender: nil)
            
            }
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                self.performSegue(withIdentifier: "segueUserUpadate", sender: nil)
                
                
            }
            
            alert.addAction(addAlert)
            alert.addAction(updateAlert)
            alert.addAction(deleteteAlert)
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
            }
    }
    
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
   
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    @IBOutlet weak var tableViewMyWorkout: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupTableView ()
        self.tableViewMyWorkout.reloadData()
        //singIn()
    }
    
    func singIn () {
        
        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
        }
    }
    
    var nameTitleMyWorkout :  String = " "
    var nameMyWorkout : String = ""
    var descriptionMyWorkout :  String = " "
    
    //[variables class ModelUserMyWorkoutCell]
    var nameWorkout: String = " "
    var dateWorkout: String = " "
    var descriptionWorkout: String = " "
    
    func initiate(nameMyWorkout: String, descriptionMyWorkout: String ){
        
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
    }
    
    @IBAction func buttonConfirm(_ sender: Any) {
        
        newWorkout()
        
          
    }
    @IBAction func buttonCancel(_ sender: Any) {
        
        print("test field... \(nameMyWorkout) and \(descriptionMyWorkout)")
    }
    
   
    
    func newWorkout () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            let userName = user.email
            let uid = user.uid
            
            
        //}
            
            let docId = db.collection("workout").document(uid).collection("nameMyWorkout").document()
            let dbRef = db.collection("workout").document(uid)
                .collection("nameMyWorkout").document().setData([
                    
                    "idUser" : uid,
                    "idDoc" : docId,
                    "Name Workout" : "nameMyWorkout",
                    "Days this Workout" : "123",
                    "nameMyWorkout" : "321",
                    "TimesTramp" : FieldValue.serverTimestamp(),
                    
                                ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
            
        print("test func newTraining...\(db)")
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Created Workout successfully !!", message: "\(userName), I would now like to add exercises to your workout ? ", preferredStyle: .alert)
            
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                self.performSegue(withIdentifier: "segueUserWorkout", sender: nil)
            }
                alert.addAction(cancelAlert)
                alert.addAction(confirmAction)
                
                self.present(alert, animated: true, completion: nil)
            
//            if alert == confirmAction {
//
//                //passing user to workout view if he is logged in.
//                self.performSegue(withIdentifier: "segueWorkoutExercises", sender: nil)
//
//            }else{
//
//
//            }
    }
    }
    
    func testWorkout () {
       let testRef = self.db.collection("users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout")
       // self.db.collection("users").whereField(userId ?? "", isEqualTo: true).getDocuments()
        
//        self.db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl")  .getDocuments() { (querySnapshot, err) in
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
        let userId = auth.currentUser?.uid
            
            let worRef =  self.db.collection("users").document(userId!).collection("workout")
            
            
        print("userID \(userId)")
            testRef.getDocuments() { (querySnapshot, err) in
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
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
                    
                    break
                }
                }
            
        }
        }
        
        db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout").getDocuments() { (querySnapshot, err) in
            
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
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
                        
                        
            //                                    if document.documentID != nil {
            //
            //                                        print("Document exists!")
            //                                    }
                        print("workout2 idtestW... \(workoutUser?.idWorkout)")
                    case false :
                        
                        break
                    }
        
                }                   //print("\(test)")
               }
               }
    }//[end func testworkout]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableViewWorkout.reloadData()
    }
    func setupTableView () {
        
        //dataSource.data = [Any]()
        
        let testRef = self.db.collection("users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout")
        // self.db.collection("users").whereField(userId ?? "", isEqualTo: true).getDocuments()
         
 //        self.db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl")  .getDocuments() { (querySnapshot, err) in
         handle = Auth.auth().addStateDidChangeListener { auth, user in
             
         let userId = auth.currentUser?.uid
             
             let worRef =  self.db.collection("users").document(userId!).collection("workout")
             
             
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
                         }catch {
                             
                             print("error listCollection \(err)")
                         }
                     
                     break
                 }
                 }
             
         }
         //MARK: - [get data User workout]
         worRef.getDocuments() { (querySnapshot, err) in
             //[/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl/myexercises/HUuinY5uYWJ2W2rgLSTb] ref exercises in user workout.
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
                                 //[/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl/myexercises/HUuinY5uYWJ2W2rgLSTb] ref exercises in user workout.
                                     
                                     print("funcTestRef")
                                     
                                     
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
                                         
                                             let cardExercisesWorkout = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: userExercises!.imageUrl, exercisesTitle: userExercises!.name, observation: userExercises!.description)

                                             self.dataSource.data.append(cardExercisesWorkout)

                                             self.dataSource.initializeTableView(tableView: self.tableViewMyWorkout)

                                             self.tableViewMyWorkout.allowsSelection = false



                                             self.tableViewMyWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none

                                             self.tableViewMyWorkout.reloadData()
                                             
                                             print("userExercises \(userExercises!.imageUrl)")
                                         }catch {
                                             
                                             print("userExercises \(userExercises?.imageUrl)")
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
                         
                         let cardMyWorkout = ModelUserMyWorkout(delegate: self, navigationController: self.navigationController, nameWorkout: workoutUser!.name, dateWorkout: workoutUser!.days!, descriptionWorkout: workoutUser!.description)
                         
                         self.dataSource.data.append(cardMyWorkout)
                         
                         self.dataSource.initializeTableView(tableView: self.tableViewMyWorkout)
                         
                         self.tableViewMyWorkout.allowsSelection = false
                         
                         self.tableViewMyWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                         
                         self.tableViewMyWorkout.reloadData()
            
                         print("workout2 idtestW... \(workoutUser?.idWorkout)")
                     case false :
                         
                         break
                     }
         
                 }
                }
                }
         }//[listener handle]
        
        let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: "MY Workout" )
        
       // let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameMyWorkout: nameMyWorkout, descriptionMyWorkout: descriptionMyWorkout)
        
        //let cardMyWorkout = ModelUserMyWorkout(delegate: self, navigationController: self.navigationController, nameWorkout: "Test", dateWorkout: "Test", descriptionWorkout: "Test")
        
        
        dataSource.data.append(cardTitleMyWorkout)
        
        
        
       // dataSource.data.append(cardMyWorkout)
        
        dataSource.initializeTableView(tableView: tableViewMyWorkout)
        
        tableViewMyWorkout.allowsSelection = false
        
        tableViewMyWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewMyWorkout.reloadData()
        
                
    }
    
    
}
