//
//  SingInController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 09/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SingInController: UIViewController {
    
    
    @IBOutlet weak var titleSingInLabel: UILabel!
    @IBOutlet weak var emailSingInField: UITextField!
    @IBOutlet weak var passawordSingInLabel: UILabel!
    @IBOutlet weak var passawordSingInField: UITextField!
    
    var auth = Auth.auth()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // [START_EXCLUDE]
          //self.setTitleDisplay(user)
          //self.tableView.reloadData()
            
           // self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
          // [END_EXCLUDE]
        }
    }

    @IBAction func buttonSingIn(_ sender: Any) {
        
        let validateReturn = validateFields()
        
        if validateReturn == " " {
            
//
//
//            auth.addStateDidChangeListener { authentication, user in
//            //        //If the logged in user has a value, there is a logged in user.
//                    if let userLogged = user {
//
//                        //passing user to workout view if he is logged in.
//                       // self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
//                        let db = Firestore.firestore()
//
//                        let user = Auth.auth().currentUser
//
//                        if let user == nil {
//
//                            let uid = user.uid
//                        }
                    
                if let emailUser = self.emailSingInField.text {
                    if let passawordUser = self.passawordSingInField.text {
                        
                    Auth.auth().signIn(withEmail: emailUser, password: passawordUser) { [weak self] authResult, error in
                        guard let strongSelf = self else { return }
                        if error == nil {
                            
                            if error != nil {
                            //print to test on success when creating the user.
                            print("Successfully SingIn user account ! ")
                            
                            // [Alert for to user, account created successfully]
                            let alert = UIAlertController(title:  "SingIn user successfully !!", message: emailUser, preferredStyle: .alert)
                            
                            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                            
                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                //testing...
                                print("confirmAction")
                            }
                                alert.addAction(cancelAlert)
                                alert.addAction(confirmAction)
                                
                            self?.present(alert, animated: true, completion: nil)
                            
                            //passing user to workout view if he is logged in.
                            self?.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
                            
                            //if authResult != nil {
                               // self.performSegue(withIdentifier: "segueLoginRegister", sender: nil)
                                
                                //configure database
//                                let db = Firestore.firestore()
//
//                                let user = Auth.auth().currentUser
//
//                                if let user = user {
//
//                                    let uid = user.uid
//
//                                let users = db.collection("users").document(uid).setData([
//
//                                    "userId" : uid,
//                                    "name" : nameUser,
//                                    "email" : emailUser
//
//
//                                ]) { err in
//                                    if let err = err {
//                                        print("Error writing document: \(err)")
//                                    } else {
//                                        print("Document successfully written!")
//                                    }
//
//                                    }
//
//                                }//[end configure database]
                        }
                        }//[end observ userlogged]
                                }
                        }
                }
                    //[end validateFieds]
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
                        
                    }
        }// [END func buttonSingIn]
    
    
//    authentication.addStateDidChangeListener { authentication, user in
//        //If the logged in user has a value, there is a logged in user.
//        if let userLogged = user {
//
//            //passing user to main view if he is logged in.
//            //self.performSegue(withIdentifier: "segueLoginMain", sender: nil)
//
//            //creating object to identifier user type, and passing user para the correct view
//            let database = Database.database().reference()
//
//            let user = database.child("users").child( userLogged.uid )
//
//            user.observeSingleEvent(of: .value) { (snapshot) in
//
//                let data = snapshot.value as? NSDictionary
//
//                //testing data to avoid user deleted error
//                if data != nil {
//
//                    let userType = data!["usertype"] as! String
//
//                    if userType == "passenger" {
//
//                        //passing user to passenger view if he is logged in.
//                        self.performSegue(withIdentifier: "segueLoginMain", sender: nil)
//
//                    }else{
//
//                        //passing user to driver view if he is logged in.
//                         self.performSegue(withIdentifier: "DriverModelCellIdentifier", sender: nil)
//
//                    }
//
//                }
//
//            }
//        }
//
//    }
        
  

    func validateFields() -> String {
        
        if (emailSingInField.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (passawordSingInField.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}
