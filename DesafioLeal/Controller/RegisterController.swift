//
//  RegisterController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 05/04/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



class RegisterController: UIViewController {
    
    func actionReturn() {
        
        dataSource.navigationController = self.navigationController
        print("Teste voltar : \(tabBarController)")
        navigationController?.popViewController(animated: true)
        
        //self.tabBarController?.selectedIndex = 0
    }
    
    @IBOutlet weak var nameUserField: UITextField!
    @IBOutlet weak var emailUserField: UITextField!
    @IBOutlet weak var passawordUserField: UITextField!
    //@IBOutlet weak var buttonRegister: UIButton!
    
    var db = Firestore.firestore()
    let dataSource = DataSource()
    var handle: AuthStateDidChangeListenerHandle?
    var auth = Auth.auth()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionReturn()
    }
    
    func singOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Successfully singOut user !")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        
     
        let validateReturn = validateFields()
        
        if validateReturn == " " {
            
            if let nameUser = nameUserField.text {
                if let emailUser = emailUserField.text {
                    if let passawordUser = passawordUserField.text {
                        
                        let userId = auth.currentUser?.uid
                        
                        Auth.auth().createUser(withEmail: emailUser, password: passawordUser) { authResult, error in
                            
                            if userId != nil {
                                //print to fail test when creating the user.
                                print("Failed creating user account !! ")
                                let alert = UIAlertController(title: nameUser , message: " Failed create user, all fields to need filled !! \(validateReturn) id \(nameUser) !", preferredStyle: .alert)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                }
                                
                                alert.addAction(confirmAction)
                                self.present(alert, animated: true, completion: nil)
                                print("Faild create user!!")
                                
                            }else{
                                self.createDocNewUser()
                                //print to test on success when creating the user.
                                print("Successfully creating user account ! \(emailUser)")
                                
                                // [Alert for to user, account created successfully]
                                let alert = UIAlertController(title:  "Created user successfully !!", message: nameUser, preferredStyle: .alert)
                                
                                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                    
                                    
                                    
                                    self.performSegue(withIdentifier: "segueRegisterHome", sender: nil)
                                    
                                }
                                alert.addAction(cancelAlert)
                                alert.addAction(confirmAction)
                                
                                self.present(alert, animated: true, completion: nil)
                                
                                
                            }
                        }
                    }
                }
            }
            
        }else{
            //print to show if the user left any field empety!
            print("The field \(validateReturn) was not filled in !!")
            
            let alert = UIAlertController(title:  "Field empty !!", message: "The field \(validateReturn) was not filled in !!" , preferredStyle: .alert)
            
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                self.performSegue(withIdentifier: "segueHome", sender: nil)
            }
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }//[end ValidateFiels]
        
        
    }// [END func buttonRegister]
    
    func createDocNewUser () {
        
        var auth = Auth.auth()
        
        let userId = auth.currentUser?.uid
        
        if userId != nil {
            
            var  refCreate = db.collection("users").document(userId ?? "default")
            var refCreate2 = refCreate
            
            let validateReturn = validateFields()
            //
            if validateReturn == " " {
                
                if let nameUser = nameUserField.text {
                    if let emailUser = emailUserField.text {
                        if let passawordUser = passawordUserField.text {
                            
                            //configure database
                            let db = Firestore.firestore()
                   
                            if userId == auth.currentUser?.uid {
                                
                                var userRef = db.collection("users").document(userId ?? "default").setData([
                                    
                                    "userId" : userId,
                                    "name" : nameUser,
                                    "email" : emailUser
                             
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                    
                                }
                                
                                userRef = db.collection("workout")
                                    .document().setData([
                                        
                                        "name": "defaul workout",
                                        "days": "mon, fri",
                                        "description" : "squat workout" ,
                                        "idWorkout" : "test",
                                        "timesTramp" : FieldValue.serverTimestamp().description
                                        
                                    ]) { (error) in
                                        
                                        print("User and data folders, successfully created!")
                                        print("User and data folders, successfully created! \(userRef)")
                                        
                                    }
                            }
                        }
                    }
                }
            }
        }
    
                
        if userId != nil {
            
            //configure database
            let db = Firestore.firestore()
            
            let nameUser = "test22"
            let emailUser = "test22@gmail.com"
            
            
            if userId == auth.currentUser?.uid {
                
                var userRef = db.collection("users").document(userId ?? "default")
                
                var userRef2 = userRef
                
                userRef2.collection("workout")
                    .document().setData([
                        
                        "name": "defaul workout",
                        "days": "mon, fri",
                        "description" : "squat workout" ,
                        "idWorkout" : "test",
                        "timesTramp" : FieldValue.serverTimestamp()
                        
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!\(userRef2)")
                        }
                        
                        
                    }
            }
        }//[end]
        
        
    }//[end]
     
    func createWorkoutNewUser () {
        
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
                                                    print("funcWCreateWork\(document.documentID) => \(document.data())")
                                                    //print("Error getting documents: \(worRef)")
                                                    
                                                    var workoutUser : userWorkout? = nil
                                                    
                                                    do {
                                                        workoutUser = try document.data(as: userWorkout.self)
                                                        print("workout id testW... \(workoutUser?.idWorkout)")
                                                          
                                                    }catch {
                                                        
                                                        print("error listCollection \(err)")
                                                    }
                                                    print("Refexe before: \(err)")
                                                    let refExe = self.db.collection("users").document(userId ?? "default")
                                                        .collection("workout")
                                                    
                                                    let newRefWork = self.db.collection("users").document(userId ?? "default")
                                                        .collection("workout")
                                                    //users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl/myexercises
                                                   
                                                    newRefWork.document().setData([
                                                        
                                                        "name" : "default",
                                                        "description" : "default",
                                                        "urlImage" : "default",
                                                        "idWorkout" : document.documentID
                                                        
                                                    ]) { err in
                                                        if let err = err {
                                                            print("Error writing document: \(err)")
                                                        } else {
                                                            print("Document successfully written!")
                                                            
                                                            //[Alert for to user, account created successfully]
                                                            let alert = UIAlertController(title: user?.displayName , message: "Workout created successfully !!", preferredStyle: .alert)
                                                            
                                                            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                                            
                                                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                                //testing...
                                                                print("confirmAction")
                                                                self.performSegue(withIdentifier: "segueNewWorkoutMyWorkout", sender: nil)
                                                            }
                                                            alert.addAction(cancelAlert)
                                                            alert.addAction(confirmAction)
                                                            
                                                            
                                                            self.present(alert, animated: true, completion: nil)
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    break
                                                    
                                                    print("test func newTraining...\(err)")
                                         
                                }//[end get workout]
                                 
                            }
                          
                    }//end if validatefields
                      
                }
          
    }
   
    //Method for validate user-entered fields
    func validateFields() -> String {
        
        if (self.nameUserField.text?.isEmpty)! {
            
            return "Name"
            
        }else if (self.emailUserField.text?.isEmpty)! {
            passawordUserField.textContentType = .emailAddress
            return "email"
        }else if (self.passawordUserField.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}
