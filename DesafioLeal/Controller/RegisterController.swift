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

class RegisterController: UIViewController {
//    internal init(nameUserField: UITextField? = nil, emailUserField: UITextField? = nil, passawordUserField: UITextField? = nil) {
//        self.nameUserField = nameUserField
//        self.emailUserField = emailUserField
//        self.passawordUserField = passawordUserField
//
//    }
    

    
    
    @IBOutlet weak var nameUserField: UITextField!
    @IBOutlet weak var emailUserField: UITextField!
    @IBOutlet weak var passawordUserField: UITextField!
    //@IBOutlet weak var buttonRegister: UIButton!
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    var self.nameUser = nameUserField
//    var emailUser = emailUserField
//    var passawordUser = passawordUserField
    
//    func initiate(nameUser : String, emailUser : String, passawordUser : String){
//        self.nameUser = nameUser
//        self.emailUser = emailUser
//        self.passawordUser = passawordUser
//        //self.urlDetails = urlDetails
//    }
    
    
    @IBAction func buttonRegister(_ sender: Any) {
        
//        let nameUser = nameUserField
//        let emailUser = emailUserField
//        let passawordUser = passawordUserField
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
                            
                            //passing user to workout view if he is logged in.
                            self.performSegue(withIdentifier: "segueRegister", sender: nil)
                            
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
                                
                                }
                                }
                        }
                    }
                }
            }
        }
            
        }
        }// [END func buttonRegister]
        
    
    func singIn () {
        
        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
        }
    }
    
    func newTraining () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
        
            let uid = user.uid
        //}
       
            let db = db.collection("Users").document(uid)
                .collection("NameChoiceUser2").document("NameChoiceUser2").setData(["Exercicies 1" : "NameChoiceUser2"]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
        print("test func newTraining...\(db)")
    }
        
    }
    
    //Method for validate user-entered fields
    func validateFields() -> String {
        
        if (self.emailUserField.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (self.nameUserField.text?.isEmpty)! {
            
            return "Full Name"
        }else if (self.passawordUserField.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}

