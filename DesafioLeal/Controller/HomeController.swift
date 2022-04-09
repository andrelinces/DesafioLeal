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
    
    override func viewDidLoad() {
       
        singOut()
        
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // [START_EXCLUDE]
          //self.setTitleDisplay(user)
          //self.tableView.reloadData()
            
            self.singOut()
            
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
