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


class AccountController: UIViewController {
    
    @IBOutlet weak var buttonSingIN: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    
    
    var db = Firestore.firestore()
    
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
    
    // [START codable_struct]
    public struct City: Codable {

        let name: String
        let state: String?
        let country: String?
        let isCapital: Bool?
        let population: Int64?

        enum CodingKeys: String, CodingKey {
            case name
            case state
            case country
            case isCapital = "capital"
            case population
        }

    }
    // [END codable_struct]
    
    // [START codable_struct]
    public struct exercisesCategories: Codable {

        let name: String
        let urlImage: String?
        let observation: String?
        

        enum CodingKeys: String, CodingKey {
            case name
            case urlImage
            case observation
            
        }

    }
    
    public struct userWorkout: Codable {

        let name: String
        let urlImage: String?
        let description: String?
        

        enum CodingKeys: String, CodingKey {
            case name
            case urlImage
            case description
            
        }

    }
    
    // [END codable_struct]
    
}// [END class AccountController]


