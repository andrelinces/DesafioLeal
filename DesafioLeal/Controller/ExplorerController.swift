//
//  ExplorerController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 13/04/22.
//

import UIKit
import FirebaseAuth

class ExplorerController: UIViewController {
    
    var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singOut()
        
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
