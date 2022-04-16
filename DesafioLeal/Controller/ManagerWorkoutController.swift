//
//  ManagerWorkoutController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 11/04/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class ManagerWorkoutController: UIViewController {
    
    var auth = Auth.auth()
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var labelTitleExercises: UILabel!
    @IBOutlet weak var fieldNameExercises: UITextField!
    @IBOutlet weak var labelDescriptionExercises: UILabel!
    @IBOutlet weak var fieldDescriptionExercises: UITextField!
    @IBOutlet weak var labelImage: UILabel!
    @IBOutlet weak var fieldImageUrl: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createExercises(_ sender: Any) {
        print("click in button createExercises..")
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let validateReturn = self.validateFields()
            let userId = auth.currentUser?.uid
            if validateReturn == " " {
                
                if let nameExercises = self.fieldNameExercises.text {
                    if let descriptionExercises = self.fieldDescriptionExercises.text {
                        if let imageUrlExercises = self.fieldImageUrl.text {
                            
                            
                            if userId == nil {
                                //[error user dont logged!!]
                                print("user anonymous, our nil? \(String(describing: user))")
                                
                            }
                            print("userID \(String(describing: userId))")
                            let worRef = self.db.collection("users").document(userId ?? "default").collection("workout")
                            
                            //[checking if workout exists !]
                            worRef.getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    
                                    print("Error getting documents: \(err)")
                                    
                                    //MARK: --[Alert for to user, ERROR created EXERCISES!]
                                    let alert = UIAlertController(title: user?.displayName , message: "Error create exercises \(err) !!", preferredStyle: .alert)
                                    
                                    let confirmAction = UIAlertAction(title: "OK !", style: .default) { alertAction in
                                        //testing...
                                        print("confirmAction")
                                        self.performSegue(withIdentifier: "segueNewExercisesMyWorkout", sender: nil)
                                    }
                                    alert.addAction(confirmAction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    //MARK: -- [Alert for to user, ERROR created EXERCISES!]
                                    
                                } else {
                                    for document in querySnapshot!.documents {
                                        
                                        print("CreateExercicies, documents\(document.documentID) => \(document.data())")
                                        //print("Error getting documents: \(worRef)")
                                        
                                        var workoutUser : userWorkout? = nil
                                        
                                        do {
                                            workoutUser = try document.data(as: userWorkout.self)
                                            print("Managerworkout id testW... \(workoutUser?.idWorkout)")
                                            
                                        }catch {
                                            
                                            print("error listCollection \(String(describing: user))")
                                        }
                                        //[testing here...]
                                        
                                        var refNewExe = worRef.document(userId ?? "default").collection("myexercises").document()
                                        
                                        print("Refexe before: \(refNewExe)")
                                        refNewExe.setData([
                                            
                                            "name" : nameExercises,
                                            "description" : descriptionExercises,
                                            "urlImage" : imageUrlExercises,
                                            "idExercises" : refNewExe.documentID,
                                            "days" : "default"
                                            
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                                
                                                //[Alert for to user, Error!]
                                                let alert = UIAlertController(title: user?.displayName , message: "Error create exercises, checking field and try again !!", preferredStyle: .alert)
                                                
                                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                    //testing...
                                                    
                                                    print("confirmAction")
                                                    self.performSegue(withIdentifier: "segueNewExercisesMyWorkout", sender: nil)
                                                }
                                                
                                                alert.addAction(confirmAction)
                                                self.present(alert, animated: true, completion: nil)
                                                
                                            }else{
                                                print("Document successfully written!")
                                                
                                                //[Alert for to user, account created successfully]
                                                let alert = UIAlertController(title: user?.displayName , message: "Exercises created successfully !!", preferredStyle: .alert)
                                                
                                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                    //testing...
                                                    print("confirmAction")
                                                    self.dismiss(animated: true, completion: nil)
                                                    self.performSegue(withIdentifier: "segueNewExercisesMyWorkout", sender: nil)
                                                }
                                                
                                                alert.addAction(confirmAction)
                                                self.present(alert, animated: true, completion: nil)
                                                  
                                            }
                                              
                                        }
                                    }//[END FOR...]
                                }
                            }
                        }
                        
                    }//[end get workout]
                    
                }
            }
            
        }//[end get exercises]
        
    }//MARK: -- [END button CreateExercises]
                                        
  
        
    func validateFields() -> String {
        
        if (self.fieldNameExercises.text?.isEmpty)! {
            
            return "Name"
            
        }else if (self.fieldDescriptionExercises.text?.isEmpty)! {
            
            return "email"
        }else if (self.fieldImageUrl.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}

