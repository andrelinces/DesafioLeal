//
//  TrainingController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 31/03/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class WorkoutController: UIViewController, ModelExercisesPosterCallBack, ModelWorkoutPosterCellCallBack, ModelWorkoutCellCallBack {
    func actionClickCardView(indexPath: IndexPath) {
        print("click in card!!\(indexPath)")
        
        if indexPath.row == 1 {
            
            
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Menu Workout", message: "Do your want to editing your workout ?", preferredStyle: .alert)
           
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                self.performSegue(withIdentifier: "segueUserWorkout", sender: nil)
            }
                
                let cardWorkoutPoster = UIAlertController(nibName: "ModelMyWorkoutCellIdentifier", bundle: Bundle.main)

//            alert.addTextField { UITextField in
//                self.titleWorkout = ""
//            }
           
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
            performSegue(withIdentifier: "segueMyWorkout" , sender: nil)
        }
            
    }
    var db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //testWorkout()
        print("test appear home")
        // [START auth_listener]
//        handle = Auth.auth().addStateDidChangeListener { auth, user in
//          // [START_EXCLUDE]
//          //self.setTitleDisplay(user)
//          //self.tableView.reloadData()
//            print("handle: \(self.handle)")
//            if  user?.isAnonymous == false {
//                let testUser = auth.currentUser?.email
//                let userId = auth.currentUser?.uid
//                let refUser =   self.db.collection("users").whereField("name", isEqualTo: userId)
//
//                let uRef = self.db.collection("users")
//                self.db.collection("users").getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            switch document.documentID == userId {
//
//
//                            case true : //(document.exists):
//                                let test = document.documentID
//                                print("Document..\(document.documentID) => \(document.data())");
//                                print("\(test)")
//
//                                var listExercises : exercisesCategories? = nil
//                                var workoutUser : userWorkout? = nil
//
//                                do {
//
//                                    listExercises = try document.data(as: exercisesCategories.self)
//                                    workoutUser = try document.data(as: userWorkout.self)
//                                    print("workout id... \(workoutUser?.idWorkout)")
//                                }catch {
//
//                                    print("error listCollection \(err)")
//                                }
//
//                                let uRef = self.db.collection("users").document()
//                                let wRef = uRef.collection("workout")
//
//                                self.db.collection("workout").getDocuments() { (querySnapshot, err) in
//                                    if let err = err {
//                                        print("Error getting documents: \(err)")
//                                    } else {
//                                        for document in querySnapshot!.documents {
//
//
//                                var workoutUser : userWorkout? = nil
//
//                                do {
//
//                                    workoutUser = try document.data(as: userWorkout.self)
//
////                                    if document.documentID != nil {
////
////                                        print("Document exists!")
////                                    }
//
//                                }catch {
//
//                                    print("error listCollection \(err)")
//                                }
//                                        }                   //print("\(test)")
//                                       }
//                                       }
//
//
//                                print("name user? \(listExercises?.name)")
//                                print ("User ?: \(testUser)")
//                                print("Document..\(document.documentID) => \(document.data())")
//                                print ("User id: \(userId)")
//
//                                // [Alert for to user, account created successfully]
//                                let alert = UIAlertController(title:  "Welcome \(listExercises?.name)!", message: "\(listExercises?.name), Do you want add this exercise from your workout? ?", preferredStyle: .alert)
//
//                                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//                                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
//                                    //testing...
//                                    print("confirmAction")
//
//                                    self.performSegue(withIdentifier: "segueMyWorkout", sender: nil)
//
//
//
//                                }
//                                alert.awakeFromNib()
//
//
////                                func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////                                    let alert = UIAlertController(title: "Alert", message: "This is an Alert", preferredStyle: .alert)
////                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////                                    self.present(alert, animated: true, completion: nil)
////                                }
//
//
//                                alert.awakeFromNib()
//                                alert.addAction(cancelAlert)
//                                alert.addAction(confirmAction)
//
//                                self.present(alert, animated: true, completion: nil)
//
//
//                            case false : //(document.data() .isEmpty):
//                                print("document dont exists!")
//
//                                self.db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout").getDocuments() { (querySnapshot, err) in
//                                    if let err = err {
//                                        print("Error getting documents: \(err)")
//                                    } else {
//                                        for document in querySnapshot!.documents {
//
//
//                                var workoutUser : userWorkout? = nil
//
//                                do {
//
//                                    workoutUser = try document.data(as: userWorkout.self)
//                                    print("workout id didApear... \(workoutUser?.idWorkout)")
////                                    if document.documentID != nil {
////
////                                        print("Document exists!")
////                                    }
//                                    print("workout2 id didApear... \(workoutUser?.name)")
//                                }catch {
//                                    print("workout id didApear... \(workoutUser?.days)")
//                                    print("error listCollection \(err)")
//                                }
//                                        }                   //print("\(test)")
//                                       }
//                                       }
//
//
//                                break
//
//                            }
//
//                        }
//                    }
//                print("uref: \(uRef)")
////                db.collection("users")
////                    .getDocuments() { (querySnapshot, err) in
////                        if let err = err {
////                            print("Error getting documents: \(err)")
////                        } else {
////                            for document in querySnapshot!.documents {
////                                print("Document..\(document.documentID) => \(document.data())")
////                                print ("User id: \(userId)")
////                            }
////                        }
////                }
//                print ("User emailx: \(testUser)")
//                print ("User singOut: \(refUser.description)")
//
//                // [Alert for to user, account created successfully]
//                let alert = UIAlertController(title:  "Save Exercises", message: "Do you want add this exercise from your workout? ?", preferredStyle: .alert)
//
//                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
//                    //testing...
//                    print("confirmAction")
//
//
//
//                    //let myCustomView: CustomView = UIView.fromNib()
//                }
//
//
//                alert.addAction(cancelAlert)
//                alert.addAction(confirmAction)
//
//                self.present(alert, animated: true, completion: nil)
//
//            }
//            //self.singOut()
//
//            //self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
//          // [END_EXCLUDE]
//        }
//        }
    }//[end didAppear]
    
//    func singOut() {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            print("Successfully singOut user !")
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//    }
    

    
    func testWorkout () {
       let testRef = self.db.collection("users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout")
       // self.db.collection("users").whereField(userId ?? "", isEqualTo: true).getDocuments()
        
//        self.db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout/qmkRFkUnfn6Hn9DnlyWl")  .getDocuments() { (querySnapshot, err) in
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
        let userId = auth.currentUser?.uid
            
            let worRef =  self.db.collection("users").document(userId!).collection("workout")
            
            
        print("userID \(userId)")
            testRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("funcWorkout\(document.documentID) => \(document.data())")
                    //print("Error getting documents: \(worRef)")
                    
                   
                        var workoutUser : userWorkout? = nil
                    
                        
                        do {
                            workoutUser = try document.data(as: userWorkout.self)
                            print("workout id testW... \(workoutUser?.name)")
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
                    
                    break
                }
                }
            
        }
        }
        
        db.collection("/users/lYcWf4U78cOFOQ7Wo2eQjDv786F3/workout").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    switch document.documentID != nil {
     
      
                    case true :
                        
                        var workoutUser : userWorkout? = nil
                        
                        
                        do {
                            workoutUser = try document.data(as: userWorkout.self)
                            print("workout idtestW... \(workoutUser?.name)")
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
                        
                        
            //                                    if document.documentID != nil {
            //
            //                                        print("Document exists!")
            //                                    }
                        print("workout2 idtestW... \(workoutUser?.idWorkout)")
                    case false :
                        
                        break
                    }
        
                }                   //print("\(test)")
               }
               }
        
    }
        
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    //var auth = Auth.auth().currentUser?.uid
    
   
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testWorkout()
        print("test workoutcontroller...")
        
        
        setupTableView()
    }
    
    //Variables inicialization
    var imagePosterWorkout : String = ""
    var titleWorkout : String = ""
    var imageWorkout : String = ""
    var myWorkout : String = ""
    var descriptionWorkout : String = " "
    
    func initiate(imagePosterWorkout : String, titleWorkout : String,  descriptionWorkout: String){
        self.imagePosterWorkout = imagePosterWorkout
        self.titleWorkout = titleWorkout
        self.descriptionWorkout = descriptionWorkout
        
        
        //self.urlDetails = urlDetails
    }
    
    func setupTableView () {
        
        //dataSource.data = [Any]()
        
        let cardWorkoutPoster = ModelWorkoutPoster(delegate: self, navigationController: self.navigationController, imagePosterWorkout: imagePosterWorkout, titleWorkout: "titleWorkout", descriptionWorkout: descriptionWorkout )
        
        let cardWorkout = ModelWorkout(delegate: self, imageWorkout: imageWorkout, myWorkout: "My Workout" )
        
        
        dataSource.data.append(cardWorkoutPoster)
        
        dataSource.data.append(cardWorkout)
        
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                
    }
    
    
    func newTraining () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
        
            let uid = user.uid
        //}
       
            let db = db.collection("Users").document(uid)
                .collection("NameChoiceUser2").document("NameChoiceUser2").setData(["Exercicies 1" : "NameChoiceUser2"]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
        print("test func newTraining...\(db)")
    }
    }

//    func singIn () {
//
//        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
//
//        }
//    }
    
    

}

//extension UIView {
//    class func fromNib<T: UIView>() -> T {
//        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
//    }
//}

class UIViewFromNib: UIView {
    
    var contentView: UIView!
    
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    //MARK:
    func loadViewFromNib() {
        let bundle = Bundle(for: UIViewFromNib.self)
        contentView = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
}
