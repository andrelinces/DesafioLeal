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
    
    let dataSource = DataSource()
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var titleSingInLabel: UILabel!
    @IBOutlet weak var emailSingInField: UITextField!
    @IBOutlet weak var passawordSingInLabel: UILabel!
    @IBOutlet weak var passawordSingInField: UITextField!
    
    var auth = Auth.auth()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //actionReturn()
       
    }
    
    @IBAction func buttonExit(_ sender: Any) {
        
        actionReturn()
//        self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
    }
    
    
    func actionReturn() {
        print("Back SingIn: \(tabBarController)")
        navigationController?.popViewController( animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.selectedIndex = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }//[End WillAppear]
    
    
    
    func checkUserLogin () {
  
        
                // [START auth_listener]
                handle = Auth.auth().addStateDidChangeListener { auth, user in
        
                    if  user?.isAnonymous == true {
                        if user?.uid == nil {
                            
                        print ("User singOut: \(user)")
                              
                            // [Alert for to user, account SingOut]
                            let alert = UIAlertController(title:  "SingOut user !!", message: "Do you need singIn for to use APP!", preferredStyle: .alert)

                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                //testing...
                                print("confirmAction")

                                self.performSegue(withIdentifier: "segueSingInHome", sender: nil)
                            }

                                alert.addAction(confirmAction)

                            self.present(alert, animated: true, completion: nil)
                            
                        }else{
                            
                            print("Failed SingInButton  !! ")

                            // [Alert for to user, account created successfully]
                            let alert = UIAlertController(title: "Failed !!" , message: "SingIn Failed Try again!!", preferredStyle: .alert)

                            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                //testing...
                                print("confirmAction")

                            }

                            alert.addAction(confirmAction)

                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    }
                    
                    
                }
    }
 

    @IBAction func buttonSingIn(_ sender: Any) {
        
        let validateReturn = validateFields()
        
        if validateReturn == " " {
            
            if let emailUser = self.emailSingInField.text {
                if let passawordUser = self.passawordSingInField.text {
                    
                    handle = Auth.auth().addStateDidChangeListener { auth, user in
                        
                        var userId = user?.uid
                        Auth.auth().signIn(withEmail: emailUser, password: passawordUser) { [weak self] authResult, error in
                            guard let strongSelf = self else { return }
                            
                  
                        }
                        if user?.uid == nil {
                            
                            print("Failed singIN\(String(describing: userId))")
                            
                        
                            if validateReturn == nil {
                                
                                //print to test on success when creating the user.
                                print("Failed SingIn user  !! \(validateReturn)")
                                
                                //print to show if the user left any field empety!
                                
                                let alert = UIAlertController(title: "Failed !!" , message: "SingIn Failed Try again, checking all filled fieds!!", preferredStyle: .alert)
                                // [Alert for to user, account created successfully]
                                let alertFailed = UIAlertController(title:  "Field empty !!", message: "The field \(validateReturn) was not filled in !!" , preferredStyle: .alert)
                                
                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                    //testing...
                                    print("confirmAction")
                        
                            }
                        
                        
                            }else{
                                
                                print("Successfully singIN\(String(describing: user?.uid))")
                            // [Alert for to user, account created successfully]
                            let alert = UIAlertController(title:  "SingIn user successfully !!", message: emailUser, preferredStyle: .alert)
                     
                            
                            let confirmSingIn = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                                //testing...
                                print("confirmAction")
                                
                                self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
                            }
                            
                            
                            alert.addAction(confirmSingIn)
                            
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }//[end buttonSingIn]
    
    func validateFields() -> String {
        
        if (emailSingInField.text?.isEmpty)! {
            
            return "E-mail"
            
        }else if (passawordSingInField.text?.isEmpty)! {
            
            return "Passaword"
            
        }
        
        return " "
    }
    
}
