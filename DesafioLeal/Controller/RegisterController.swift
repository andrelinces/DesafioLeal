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
    
    @IBOutlet weak var nameUserField: UITextField!
    @IBOutlet weak var emailUserField: UITextField!
    @IBOutlet weak var passawordUserField: UITextField!
    //@IBOutlet weak var buttonRegister: UIButton!
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        
     
        let validateReturn = validateFields()
        
        if validateReturn == " " {
            
            if let nameUser = nameUserField.text {
                if let emailUser = emailUserField.text {
                    if let passawordUser = passawordUserField.text {
                        
                        Auth.auth().createUser(withEmail: emailUser, password: passawordUser) { authResult, error in
                            
                            if error == nil {
                                //print to test on success when creating the user.
                                print("Successfully creating user account ! ")
                                
                                // [Alert for to user, account created successfully]
                                let alert = UIAlertController(title:  "Created user successfully !!", message: nameUser, preferredStyle: .alert)
                                
                                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                }
                                alert.addAction(cancelAlert)
                                alert.addAction(confirmAction)
                                
                                self.present(alert, animated: true, completion: nil)
                                
                                if authResult != nil {
                                    //self.performSegue(withIdentifier: "segueLoginRegister", sender: nil)
                                    
                                    //configure database
                                    let db = Firestore.firestore()
                                    
                                    let user = Auth.auth().currentUser
                                    
                                    if let user = user {
                                        
                                        let uid = user.uid
                                        
                                        let users = db.collection("users").document(uid).setData([
                                            
                                            "userId" : uid,
                                            "name" : nameUser,
                                            "email" : emailUser
                                            
                                            
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully written!")
                                            }
                                            
                                        }
                                        
                                        db.collection("workout")
                                            .document().setData([
                                                
                                                "name": "defaul workout",
                                                "days": "mon, fri",
                                                "description" : "squat workout" ,
                                                "idWorkout" : "test"
                                            
                                                ]) { (error) in
                                                
                                                print("User and data folders, successfully created!")
                                        

                                            if error != nil {
                                                //Show error message
                                                print("Error creating the user\(error)")
                                            }
                                        }
                                    }
                                }
                            }else{
                                let alert = UIAlertController(title: nameUser , message: " Failed create user, all fields to need filled !! Type valid email !", preferredStyle: .alert)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                }
                                
                                alert.addAction(confirmAction)
                                self.present(alert, animated: true, completion: nil)
                                print("Faild create user!!")
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
            }
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }//[end ValidateFiels]
        
        
    }// [END func buttonRegister]
        
   
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

