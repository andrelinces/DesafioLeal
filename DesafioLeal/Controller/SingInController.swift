//
//  SingInController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 09/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SingInController: UIViewController {
    
    
    @IBOutlet weak var titleSingInLabel: UILabel!
    @IBOutlet weak var emailSingInField: UITextField!
    @IBOutlet weak var passawordSingInLabel: UILabel!
    @IBOutlet weak var passawordSingInField: UITextField!
    
    var auth = Auth.auth()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if  user?.isAnonymous == true {
                print ("User singOut: \(user)")
            }
      
        }
    }

    @IBAction func buttonSingIn(_ sender: Any) {
        
        let validateReturn = validateFields()
        
        if validateReturn == " " {
   
                if let emailUser = self.emailSingInField.text {
                    if let passawordUser = self.passawordSingInField.text {
                        
                    Auth.auth().signIn(withEmail: emailUser, password: passawordUser) { [weak self] authResult, error in
                        guard let strongSelf = self else { return }
                        print("Successfully singIN")
                        if error != nil {
                            //[remove for to alert the user]
                            if error == nil {
                            //print to test on success when creating the user.
                            print("Successfully SingIn user account ! ")
                            
                            // [Alert for to user, account created successfully]
                            let alert = UIAlertController(title:  "SingIn user successfully !!", message: emailUser, preferredStyle: .alert)
                            
                            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                            
                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                //testing...
                                print("confirmAction")
                                
                                self?.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
                            }
                                alert.addAction(cancelAlert)
                                alert.addAction(confirmAction)
                                
                            self?.present(alert, animated: true, completion: nil)
                        
                            }else{
                                
                                print("SingIn failed!")
                                
                                // [Alert for to user, account created successfully]
                                let alert = UIAlertController(title: "Failed !!" , message: "SingIn Failed Try again!!", preferredStyle: .alert)
                               
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                                }
                                    
                                    alert.addAction(confirmAction)
                                    
                                self?.present(alert, animated: true, completion: nil)
                                
                            }
                        }//[end observ userlogged]
                                }
                        }
                }
                    //[end validateFieds]
                    }else{
                        //print to show if the user left any field empety!
                        print("The field \(validateReturn) was not filled in !!")
                        
                        let alert = UIAlertController(title:  "Field empty !!", message: "The field \(validateReturn) was not filled in !!" , preferredStyle: .alert)
                        
                        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        
                        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                            //testing...
                            print("confirmAction")
                        }
                            alert.addAction(cancelAlert)
                            alert.addAction(confirmAction)
                            
                        self.present(alert, animated: true, completion: nil)
                        
                    }
        }// [END func buttonSingIn]
    
    
    func validateFields() -> String {
        
        if (emailSingInField.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (passawordSingInField.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}
