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
        self.dismiss(animated: true, completion: nil)
           
    }
    
    
    @IBAction func createWorkout(_ sender: Any) {
        
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let validateReturnWorkout = self.validateFieldsWorkout()
            
            if validateReturnWorkout == " " {
                
                if let nameWorkout = self.fieldNameWorkout.text {
                    if let descriptionWorkout = self.fieldDescriptionWrokout.text {
                        if let daysWorkout = self.fieldDaysWorkout.text {
                            
                            let userId = auth.currentUser?.uid
                            if userId == nil {
                                
                                print("user anonymous, our nil? \(user)")
                            }else{
                                
                                //[User singIn!!]
                                
                                var refExe = self.db.collection("users").document(userId ?? "default")
                                    .collection("workout").document()
                                
                                let newRefWork = self.db.collection("users").document(userId ?? "default")
                                    .collection("workout").document(userId ?? "default")
                                //users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl/myexercises
                                
                                newRefWork.setData([
                                    
                                    "name" : nameWorkout,
                                    "description" : descriptionWorkout,
                                    "days" : daysWorkout,
                                    "idWorkout" : userId
                                    
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                        
                                        //[Alert for to user, account created successfully]
                                        let alert = UIAlertController(title: user?.displayName , message: "Workout created successfully, Add exercises into your workout! !!", preferredStyle: .alert)
                                        
                                        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                        
                                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                            //testing...
                                            print("confirmAction")
                                            self.performSegue(withIdentifier: "segueNewWorkoutMyWorkout", sender: nil)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                        alert.addAction(cancelAlert)
                                        alert.addAction(confirmAction)
                                        
                                        self.present(alert, animated: true, completion: nil)
                                        
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

