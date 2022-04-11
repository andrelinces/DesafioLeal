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
        
        print("handle: \(self.handle?.description)")
        print("test didload home")
       
    }
    
//    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("test appear home")
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // [START_EXCLUDE]
          //self.setTitleDisplay(user)
          //self.tableView.reloadData()
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
                                 
                                
                            case true : //(document.exists):
                                let test = document.documentID
                                print("Document..\(document.documentID) => \(document.data())");
                                print("\(test)")
                                
                                var listExercises : exercisesCategories? = nil
                                
                                do {
                                    
                                    listExercises = try document.data(as: exercisesCategories.self)
                                    
                                    
                                }catch {
                                    
                                    print("error listCollection \(err)")
                                }
                                print("name user? \(listExercises?.name)")
                                print ("User ?: \(testUser)")
                                print("Document..\(document.documentID) => \(document.data())")
                                print ("User id: \(userId)")
                                
                                // [Alert for to user, account created successfully]
                                let alert = UIAlertController(title:  "Welcome \(listExercises!.name)!", message: "\(listExercises?.name), Do you want to workout now? ", preferredStyle: .alert)
                                
                                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                    self.performSegue(withIdentifier: "segueHomeMyWorkout", sender: nil)
                                    //alert.awakeFromNib()
                                
                                }
                                alert.addAction(cancelAlert)
                                alert.addAction(confirmAction)
                                
                                self.present(alert, animated: true, completion: nil)
                                
                                
                            case false : //(document.data() .isEmpty):
                                print("document dont exists!")
                                break
                                
                            }
                            
                        }
                    }
                print("uref: \(uRef)")
//                db.collection("users")
//                    .getDocuments() { (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        } else {
//                            for document in querySnapshot!.documents {
//                                print("Document..\(document.documentID) => \(document.data())")
//                                print ("User id: \(userId)")
//                            }
//                        }
//                }
                print ("User emailx: \(testUser)")
                print ("User singOut: \(refUser.description)")
                
                // [Alert for to user, account created successfully]
                let alert = UIAlertController(title:  "Save Exercises", message: "Do you want add this exercise from your workout? ?", preferredStyle: .alert)
                
                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                    //testing...
                    print("confirmAction")
                    
                    
                }
                
                
                alert.addAction(cancelAlert)
                alert.addAction(confirmAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            //self.singOut()
            
            //self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
          // [END_EXCLUDE]
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

}
