//
//  MyWorkoutController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 07/04/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class MyWorkoutController: UIViewController, ModelTitleMyWorkoutCellCallBack, ModelMyWorkoutCellCallBack {
    
    func actionClickCardView(indexPath: IndexPath) {
        print("clicou no card\(indexPath.item)")
        
        
    }
    
    var db = Firestore.firestore()
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupTableView ()
        
        //singIn()
    }
    
    func singIn () {
        
        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
        }
    }
    
    var nameTitleMyWorkout :  String = " "
    var nameMyWorkout : String = ""
    var descriptionMyWorkout :  String = " "
    
    func initiate(nameMyWorkout: String, descriptionMyWorkout: String ){
        
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
    }
    
    @IBAction func buttonConfirm(_ sender: Any) {
        
        newWorkout()
        
          
    }
    @IBAction func buttonCancel(_ sender: Any) {
        
        print("test field... \(nameMyWorkout) and \(descriptionMyWorkout)")
    }
    
    
    
    
    
    func newWorkout () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            let userName = user.email
            let uid = user.uid
            
            
        //}
            
            let docId = db.collection("workout").document(uid).collection("nameMyWorkout").document()
            let dbRef = db.collection("workout").document(uid)
                .collection("nameMyWorkout").document().setData([
                    
                    "idUser" : uid,
                    "idDoc" : docId,
                    "Name Workout" : "nameMyWorkout",
                    "Days this Workout" : "123",
                    "nameMyWorkout" : "321",
                    "TimesTramp" : FieldValue.serverTimestamp(),
                    
                                ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
            
        print("test func newTraining...\(db)")
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Created Workout successfully !!", message: "\(userName), I would now like to add exercises to your workout ? ", preferredStyle: .alert)
            
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                self.performSegue(withIdentifier: "segueWorkoutExercises", sender: nil)
            }
                alert.addAction(cancelAlert)
                alert.addAction(confirmAction)
                
                self.present(alert, animated: true, completion: nil)
            
//            if alert == confirmAction {
//
//                //passing user to workout view if he is logged in.
//                self.performSegue(withIdentifier: "segueWorkoutExercises", sender: nil)
//
//            }else{
//
//
//            }
    }
    }
    
    func setupTableView () {
        
        //dataSource.data = [Any]()
        
        let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: " " , titleMyWorkout: "MY Workout" )
        
        let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameMyWorkout: nameMyWorkout, descriptionMyWorkout: descriptionMyWorkout)
        
        
        dataSource.data.append(cardTitleMyWorkout)
        
        dataSource.data.append(cardMyWorkout)
        
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                
    }
    
    
}
