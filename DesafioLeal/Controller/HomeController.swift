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
      actionReturn()
           //testCreateDoc()
        //testGetExer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("test appear home")
              
    }
    
    func testGetExer () {
        
        let testRef = db.collection("users/yvfX1VrDLLfNO0ZQXLRRc87N9vl1/workout/Zqt7GQgkmEMCBQryhCdg/myexercises")
        testRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("funcTesGet GET\(document.documentID) => \(document.data())")
                    
                    var workoutUser : userWorkout? = nil
                    
                    do {
                        workoutUser = try document.data(as: userWorkout.self)
                    }catch{
                        print("Error getting documents testGEt: \(err)")
                        
                    }
                }
            }
        }
    }
    
    
    
    
    func testCreateDoc () {
        
        var auth = Auth.auth()
        
        let userId = auth.currentUser?.uid
        
        if userId != nil {
            
            //configure database
            let db = Firestore.firestore()
            
            let nameUser = "test22"
            let emailUser = "test22@gmail.com"
            
            
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
                        "timesTramp" : FieldValue.serverTimestamp()
                        
                    ]) { (error) in
                        
                        print("User and data folders, successfully created!")
                        print("User and data folders, successfully created! \(userRef)")
                        
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
    

    
    func actionReturn() {
        print("Back SingIn: \(tabBarController)")
        navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 0
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


