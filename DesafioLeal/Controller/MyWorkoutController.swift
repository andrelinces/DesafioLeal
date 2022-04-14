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
        
        self.tabBarController?.selectedIndex = 5
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
                                print("funcWActionCliMyWorkout\(document.documentID) => \(document.data())")
                               
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
                                                        print("userExercises \(userExercises?.urlImage)")
                                                    }catch {
                                                        
                                                        print("userExercises \(userExercises?.urlImage)")
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
//                                    let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameMyWorkout: self.nameWorkout, descriptionMyWorkout: self.descriptionWorkout)
//                                 
//                                    self.dataSource.data.append(cardMyWorkout)
//                                    
//                                    self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
//                                    
//                                    self.tableViewWorkout.allowsSelection = false
//                                    
//                                    self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
//                                    
//                                    self.tableViewWorkout.reloadData()
                                    
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
      
        setupTableView ()
        //testGetExer ()
        deleteExercises()
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
    
    func alertDelete (){
        
        
        // [Alert for to user, account created successfully]
        let alert = UIAlertController(title:  "Choice a option)!", message: " Exercises delete Successfully!! ", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            
            
            self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
            
            
            self.tableViewWorkout.reloadData()

        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            
            
            self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
          

        }

        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
            //testing...
            print("confirmAction")
            self.performSegue(withIdentifier: "segueBackMyWorkout", sender: nil)
            
            
            self.tableViewWorkout.reloadData()

        }

        alert.addAction(confirmAction)

        present(alert, animated: true, completion: nil)


        alert.addAction(delete)
        alert.addAction(cancelAlert)
        alert.addAction(confirmAction)

        present(alert, animated: true, completion: nil)
        
    }
    
    func deleteExercises () {
        
        var handle: AuthStateDidChangeListenerHandle?
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            if userId == nil {
                //[User don't logged]
                print("Userid deleteExercises: \(String(describing: userId))")
                
            }else{
                //[REF firestore]
                let worksRef =  self.db.collection("users").document(userId ?? "id").collection("workout")
                
                worksRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        
                    } else {
                        for document in querySnapshot!.documents {
                            print("funcWorkoutDeleteExe\(document.documentID) => \(document.data())")
                            
                            var workoutUser : userWorkout? = nil
                            
                            do {
                                workoutUser = try document.data(as: userWorkout.self)
                                print("workout id testW... \(workoutUser?.name)")
                                
                                let idWork = workoutUser?.idWorkout
                                print("WorkoutID delete\(String(describing: idWork))")
                                let exercRef = worksRef.document().collection("exercises")
                                
                                //[Receving data from user exercises.]
                                for document in querySnapshot!.documents {
                                    
                                    
                                    
                                    var userExercises : userWorkoutExercises? = nil
                                    
                                    userExercises = try document.data(as: userWorkoutExercises.self)
                                    
                                    
                                    print("Exercises id..\(String(describing: userExercises?.idExercises))")
                                    
                                    //MARK: -- //delete exercises
                                    //                                    exercRef.document(userExercises?.idExercises).delete() { err in
                                    //                                        if let err = err {
                                    //                                            print("Error removing document: \(err)")
                                    //                                        } else {
                                    
                                    //                                }
                                    //                                }
                                    //                            }
                                    
                                    //checking cell created my workout
                                    let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameMyWorkout: self.nameWorkout, descriptionMyWorkout: self.descriptionWorkout)
                                    
                                    let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser?.name ?? "default" )
                                    
                                    self.dataSource.data.append(cardTitleMyWorkout)
                                    
                                    self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                                    
                                    self.tableViewWorkout.allowsSelection = false
                                    
                                    self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                                    
                                    self.tableViewWorkout.reloadData()
                                    
                                    
                                }
                                
                            }catch {
                                
                                print("error listCollectionExercises \(err)")
                            }
                            
                            
                            print("WorkoutID delete\(workoutUser?.idWorkout)")
                        }
                    }
                    //users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl/myexercises
                    
                }//[END for quereSnapshot]
            }//[END else userID]
            
        }//[listener handle, user singIn]
        
        
    }//[END deleteExercises]
    
    
    
    func setupTableView2 () {
        
        var handle: AuthStateDidChangeListenerHandle?
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            if userId == nil {
                //[User don't logged]
                print("Userid deleteExercises: \(String(describing: userId))")
                
            }else{
                //[REF worksRef firestore]
                let worksRef =  self.db.collection("users").document(userId ?? "id").collection("workout")
                
                worksRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        
                    } else {
                        for document in querySnapshot!.documents {
                            print("funcWorkoutDeleteExe\(document.documentID) => \(document.data())")
                            
                            var workoutUser : userWorkout? = nil
                            
                            do {
                                workoutUser = try document.data(as: userWorkout.self)
                                print("workout id testW... \(workoutUser?.name)")

                                let idWork = workoutUser?.idWorkout
                                print("WorkoutID delete\(String(describing: idWork))")
                                
//                                let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser!.name )
//
//                                self.dataSource.data.append(cardTitleMyWorkout)
//
//                                self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
//
//                                self.tableViewWorkout.allowsSelection = false
//
//                                self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
//
//                                self.tableViewWorkout.reloadData()
                               
                            }catch{
                                print("error listCollectionExercises \(String(describing: err))")
                            }
                            
                            
                        }// end for
                        
                    }
                }//[END worksRef snapshot]
 //MARK:  --
                //[REF worksRef firestore]
                let exercRef = worksRef.document().collection("myexercises")
                
                exercRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        
                    } else {
                        for document in querySnapshot!.documents {
                            print("funcWorkoutDeleteExe\(document.documentID) => \(document.data())")
                            
                            var userExercises : userWorkoutExercises? = nil
                            
                            do {
                                userExercises = try document.data(as: userWorkoutExercises.self)
                                print("workout id testW... \(userExercises?.name)")
                                
                                let idExer = userExercises?.idExercises
                                print("WorkoutID delete\(String(describing: userExercises?.idExercises))")
 

                                let cardExercisesWorkout = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: "musculacao", exercisesTitle: userExercises?.name ?? "Default", observation: userExercises?.description ?? "Default")

                                self.dataSource.data.append(cardExercisesWorkout)

                                self.dataSource.initializeTableView(tableView: self.tableViewWorkout)

                                self.tableViewWorkout.allowsSelection = false

                                self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none

                                self.tableViewWorkout.reloadData()
                                
                              
                            }catch{
                                print("error listCollectionExercises \(String(describing: err))")
                            }
                        }
                    }
                }//[END ExercRef snapshot]
                
                
                
            }
        }
    }
                                

    
    func testGetExer () {
        
        let testRef = self.db.collection("users/yvfX1VrDLLfNO0ZQXLRRc87N9vl1/workout/hXjm1ZglcdwYqR4jrpMj/myexercises")
        
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            let worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
            
            
            testRef.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error TESTREF MYWORKOUT: \(err)")
                    
                } else {
                    if userId == nil {
                        print("userId MYWORKOUT: \(String(describing: userId))")
                    }else{
                        for document in querySnapshot!.documents {
                            print("TestRef MYWorkout GET\(document.documentID) => \(document.data())")
                            
                            var userExercises : userWorkoutExercises? = nil
                            
                            do {
                                userExercises = try document.data(as: userWorkoutExercises.self)
                                print("Succes TESTGET MYWORKOUT: \(userExercises?.name)")
                                
//                                let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: "musculacao" , titleMyWorkout: workoutUser?.name ?? "Default" )
                                
                                let cardExercisesWorkout = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: "musculacao", exercisesTitle: userExercises?.name ?? "default name", observation: userExercises?.description ?? "default")
                                
                                //self.dataSource.data.append(cardTitleMyWorkout)
                                
                                self.dataSource.data.append(cardExercisesWorkout)
                                
//                                self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
//
//                                self.tableViewWorkout.allowsSelection = false
//
//                                self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                                
                                self.tableViewWorkout.reloadData()
                                
                            }catch{
                                print("Error TESTGET MYWORKOUT: \(userExercises?.name)")
                            }
                        }
                    }
                }
            }
                }
    }
        
        
        
        
        func testGetExer2 () {
            
            let testRef = self.db.collection("users/yvfX1VrDLLfNO0ZQXLRRc87N9vl1/workout/Zqt7GQgkmEMCBQryhCdg/myexercises")
            
            self.handle = Auth.auth().addStateDidChangeListener { auth, user in
                
                let userId = auth.currentUser?.uid
                
                let worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
                print("USERID documents: \(userId)")
                if userId == nil {
                    
                    print("Error getting documents: \(userId)")
                    
                } else {
                    
                    worRef.getDocuments() { (querySnapshot, err) in
                        
                        for document in querySnapshot!.documents {
                            print("TestRef MYWorkout GET\(document.documentID) => \(document.data())")
                            
                            var workoutUser : userWorkout? = nil
                            
                            do {
                                workoutUser = try document.data(as: userWorkout.self)
                                print("MyWorkout: \(workoutUser?.idWorkout)")
                            }catch{
                                print("Error getting documents testGEt: \(err)")
                                
                                let idRefWork = self.db.collection("users").document(userId ?? "default").collection("workout").document()
                                
                                let exerRef = idRefWork.collection("myexercises")
                                
                                print("Error getting documents:MYWORKOUT \(idRefWork)")
                                print("MyWorkout: \(exerRef)")
                                
                                exerRef.getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents:MYWORKOUT \(err)")
                                        
                                    } else {
                                        for document in querySnapshot!.documents {
                                            print("funcTesGet GET\(document.documentID) => \(document.data())")
            //users/yvfX1VrDLLfNO0ZQXLRRc87N9vl1/workout/Zqt7GQgkmEMCBQryhCdg/myexercises
                                            var exercList : exercisesCategories? = nil
                                            
                                            do {
                                                exercList = try document.data(as: exercisesCategories.self)
                                            }catch{
                                                print("Error getting documents testGEt: \(exercList?.name)")
                                                
                                            }
                                            print("exercList: \(exercList?.name)")
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            
        }
        
    }//[end func]
    
    func setupTableView () {
        
        
        //dataSource.data.removeAll()
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let userId = auth.currentUser?.uid
            
            let worRef =  self.db.collection("users").document(userId ?? "error").collection("workout")
            
            
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
                            self.testGetExer()
                            
                        }catch {
                            print("error listCollectionMYWorkoutController \(err)")
                        }
                        var exerRef = worRef.document().collection("myexercises")
                        
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
                                
                                self.dataSource.initializeTableView(tableView: self.tableViewWorkout)
                                
                                self.tableViewWorkout.allowsSelection = false
                                
                                self.tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
                                
                                self.tableViewWorkout.reloadData()
                            }
                        }
                    }
                    
                }
            }
                
        }
    }
             
   
}//[end class]


