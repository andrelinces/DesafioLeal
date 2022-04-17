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
       
        checkUserSingIn()
      actionReturn()
        testGetWorkout()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("test appear home")
              
    }
    
    func actionReturn() {
        print("Back SingIn: \(tabBarController)")
        navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 0
    }
    
    func testGetWorkout () {
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            var userId = auth.currentUser?.uid
        
        db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("testGetWorkout...\(document.documentID) => \(document.data())")
                        print("userId..testGetWorkout \(userId) ")
                    }
                }
            }
        }
        
    }
    
    
    func checkUserSingIn () {
        
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in

            if  user?.email == nil {
                if user?.uid == nil {
                    
                print ("User singOut: \(user)")
                      
                    // [Alert for to user, account created successfully]
                    let alert = UIAlertController(title:  "logged out user.", message: "logged out user, do you need singIn for to use APP !!", preferredStyle: .alert)
    
                    let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                        //testing...
                        print("confirmAction")
    
                        self.performSegue(withIdentifier: "segueHomeLogin", sender: nil)
                    }
    
                        alert.addAction(confirmAction)
    
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    print("Failed SingInButton  !! ")
                    
                    // [Alert for to user, account created successfully]
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
  
    }//[END funcCheckSingIn]
    
}//[end class]
