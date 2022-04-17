//
//  AccountController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 25/03/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import SwiftUI



class AccountController: UIViewController {
    
//    func actionReturn() {
//        dataSource.navigationController = self.navigationController
//        print("Teste voltar : \(tabBarController)")
//        navigationController?.popViewController(animated: false)
//
//        self.tabBarController?.selectedIndex = 1
//    }
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()
    
    let dataSource = DataSource()
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    @IBAction func buttonSingIN(_ sender: Any) {
       
        
        self.performSegue(withIdentifier: "segueSingIn", sender: nil)
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segueRegister", sender: nil)
        //self.tabBarController?.selectedIndex = 0
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //actionReturn()
        //singOut()
        
    }
    
    func checkUserSingIn () {
        
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in

            if  user?.email == nil {
                if user?.uid == nil {
                    
                print ("User singOut: \(user)")
                      
                    // [Alert for to user, account created successfully]
                    let alert = UIAlertController(title:  "User is logged in !!", message: "Welcome", preferredStyle: .alert)
    
                    let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                        //testing...
                        print("confirmAction")
    
                        self.performSegue(withIdentifier: "segueAcountWorkout", sender: nil)
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
  
    }//[END checkUserSingIn]

    func singOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Successfully singOut user !")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
   
    
}// [END class AccountController]


