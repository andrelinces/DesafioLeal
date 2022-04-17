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
    
//    func actionReturn() {
//
//        dataSource.navigationController = self.navigationController
//        print("Teste voltar : \(tabBarController)")
//        navigationController?.popViewController(animated: true)
//
//        //self.tabBarController?.selectedIndex = 3
//    }
    
    @IBOutlet weak var nameUserField: UITextField!
    @IBOutlet weak var emailUserField: UITextField!
    @IBOutlet weak var passawordUserField: UITextField!
   
    
    
    @IBAction func buttonExit(_ sender: Any) {
        self.performSegue(withIdentifier: "segueRegisterWorkout", sender: nil)
    }
    
    
    var db = Firestore.firestore()
    let dataSource = DataSource()
    var handle: AuthStateDidChangeListenerHandle?
    var auth = Auth.auth()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //actionReturn()
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
                               
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                    
                                    self.performSegue(withIdentifier: "segueRegisterWorkout", sender: nil)
                                    
                                }
                            
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
            
                            }
                        }
                    }
                }
            }
        }
    
                
        if userId != nil {
            
            //configure database
            let db = Firestore.firestore()
  
            
            if userId == auth.currentUser?.uid {
                
                var userRef = db.collection("users").document(userId ?? "default")
                
                var userRef2 = userRef
                
                userRef2.collection("workout")
                    .document(userId ?? "default").setData([
                        
                        "name": "defaul workout",
                        "days": "mon, fri",
                        "description" : "squat workout" ,
                        "idWorkout" : userId,
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
