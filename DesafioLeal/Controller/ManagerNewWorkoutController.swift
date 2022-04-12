//
//  ManagerNewWorkoutController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 12/04/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ManagerNewWorkoutController: UIViewController {
    
    var auth = Auth.auth()
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var labelTitleWorkout: UITextField!
    @IBOutlet weak var fieldNameWorkout: UITextField!
    @IBOutlet weak var labelDescriptionWorkout: UILabel!
    @IBOutlet weak var fieldDescriptionWrokout: UITextField!
    @IBOutlet weak var labelDaysWorkout: UILabel!
    @IBOutlet weak var fieldDaysWorkout: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           
    }
    
    
    @IBAction func createWorkout(_ sender: Any) {
        
        
                handle = Auth.auth().addStateDidChangeListener { auth, user in
                    
                    let validateReturnWorkout = self.validateFieldsWorkout()
                    
                    if validateReturnWorkout == " " {
                        
                        if let nameWorkout = self.fieldNameWorkout.text {
                            if let descriptionWorkout = self.fieldDescriptionWrokout.text {
                                if let daysWorkout = self.fieldDaysWorkout.text {
                                    
                                    let userId = auth.currentUser?.uid
                                    if user?.isAnonymous == true {
                                        
                                        print("user anonymous? \(user)")
                                    }
                                    
                                    //[error user dont logged!!]
                                    let worRef =  self.db.collection("users").document(userId ?? "userdontlogged").collection("workout")
                                    
                                    
                                    print("userID \(userId)")
                                    worRef.getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                            
                                        } else {
                                            for document in querySnapshot!.documents {
                                                print("funcWorkout\(document.documentID) => \(document.data())")
                                                //print("Error getting documents: \(worRef)")
                                                
                                                var workoutUser : userWorkout? = nil
                                                
                                                do {
                                                    workoutUser = try document.data(as: userWorkout.self)
                                                    print("workout id testW... \(workoutUser?.idWorkout)")
                                                      
                                                }catch {
                                                    
                                                    print("error listCollection \(err)")
                                                }
                                                print("Refexe before: \(err)")
                                                let refExe = self.db.collection("users").document(userId!)
                                                    .collection("workout")
                                               
                                                refExe.document().setData([
                                                    
                                                    "name" : nameWorkout,
                                                    "description" : descriptionWorkout,
                                                    "imageurl" : daysWorkout,
                                                    "idWorkout" : document.documentID
                                                    
                                                ]) { err in
                                                    if let err = err {
                                                        print("Error writing document: \(err)")
                                                    } else {
                                                        print("Document successfully written!")
                                                        
                                                        //[Alert for to user, account created successfully]
                                                        let alert = UIAlertController(title: user?.displayName , message: "Workout created successfully !!", preferredStyle: .alert)
                                                        
                                                        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                                        
                                                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                            //testing...
                                                            print("confirmAction")
                                                            self.performSegue(withIdentifier: "segueNewWorkoutMyWorkout", sender: nil)
                                                        }
                                                        alert.addAction(cancelAlert)
                                                        alert.addAction(confirmAction)
                                                        
                                                        
                                                        self.present(alert, animated: true, completion: nil)
                                                        
                                                    }
                                                    
                                                }
                                                
                                                break
                                                
                                                print("test func newTraining...\(err)")
                                            }
                                        }
                                    }
                                }
                                  
                            }//[end get workout]
                             
                        }
                      
                }//end if validatefields
                  
            }
            
        }//MARK: -- //[END button createWorkout]
  
    func validateFieldsWorkout() -> String {
        
        if (self.fieldNameWorkout.text?.isEmpty)! {
            
            return "Name"
            
        }else if (self.fieldDescriptionWrokout.text?.isEmpty)! {
            
            return "email"
        }else if (self.fieldDaysWorkout.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
    
}
