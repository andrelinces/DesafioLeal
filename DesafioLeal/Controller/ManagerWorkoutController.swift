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
        
           
    }
    
    func deleteExercises () {
        
        db.collection("cities").document("DC").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
    
    @IBAction func createExercises(_ sender: Any) {
        
       
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            let validateReturn = self.validateFields()
            
            if validateReturn == " " {
                
                if let nameExercises = self.fieldNameExercises.text {
                    if let descriptionExercises = self.fieldDescriptionExercises.text {
                        if let imageUrlExercises = self.fieldImageUrl.text {
                            
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
                                        print("CreateExercicies, documents\(document.documentID) => \(document.data())")
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
                                            .collection("workout").document(workoutUser!.idWorkout).collection("myexercises")
                                        print("Refexe before: \(refExe)")
                                        refExe.document().setData([
                                            
                                            "name" : nameExercises,
                                            "description" : descriptionExercises,
                                            "imageurl" : imageUrlExercises,
                                            "idExercises" : document.documentID
                                            
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully written!")
                                                
                                                //[Alert for to user, account created successfully]
                                                let alert = UIAlertController(title: user?.displayName , message: "Exercises created successfully !!", preferredStyle: .alert)
                                              
                                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                                    //testing...
                                                    print("confirmAction")
                                                    self.performSegue(withIdentifier: "segueMyWorkout", sender: nil)
                                                }
                                                
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


