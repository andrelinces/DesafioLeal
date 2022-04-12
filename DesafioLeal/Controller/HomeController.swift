//
//  HomeController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 24/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        //singOut()
        checkUserSingIn()
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("test appear home")
              
    }
    
    func checkUserSingIn () {
        
        
        print("test appear home")
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            // [START_EXCLUDE]
            
            print("handle: \(self.handle)")
            if  user?.isAnonymous == false {
                let testUser = auth.currentUser?.email
                let userId = auth.currentUser?.uid
                let refUser =   db.collection("users").whereField("name", isEqualTo: userId)
                
                let uRef = db.collection("users")
                db.collection("users").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            switch document.documentID == userId {
                                
                            case true :
                                let test = document.documentID
                                print("Document..\(document.documentID) => \(document.data())");
                                print("\(test)")
                                
                                var listExercises : exercisesCategories? = nil
                                
                                do {
                                    
                                    listExercises = try document.data(as: exercisesCategories.self)
                                    
                                }catch {
                                    
                                    print("error listCollection \(err)")
                                }
                                   
                            case false : //(document.data() .isEmpty):
                                print("document dont exists!")
                                break
                                
                            }
                            
                        }
                    }
                    
//                    // [Alert for to user, account created successfully]
//                    let alert = UIAlertController(title:  "Save Exercises", message: "Do you want add this exercise from your workout? ?", preferredStyle: .alert)
//                    
//                    let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                    
//                    let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
//                        //testing...
//                        print("confirmAction")
//                        
//                    }
//                    
//                    alert.addAction(cancelAlert)
//                    alert.addAction(confirmAction)
//                    
//                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }else {
                
                let alert = UIAlertController(title:  "Welcome !", message: " Do you don't are logged, do you need logged for to the use app, please singIn our register! ", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                    //testing...
                    print("confirmAction")
                    self.performSegue(withIdentifier: "segueHomeLogin", sender: nil)
                    
                }
                
                alert.addAction(confirmAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
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
    
}


