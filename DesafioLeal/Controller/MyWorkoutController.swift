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
        print("clicou no card\(indexPath)")
    }
    
    var db = Firestore.firestore()
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewWorkout: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupTableView ()
        
    }
    
    
    var nameTitleMyWorkout :  String = " "
    var nameMyWorkout : String = ""
    var descriptionMyWorkout :  String = " "
    
    func initiate(nameTitleMyWorkout : String, nameMyWorkout: String, descriptionMyWorkout: String ){
        self.nameTitleMyWorkout = nameTitleMyWorkout
        self.nameMyWorkout = nameMyWorkout
        self.descriptionMyWorkout = descriptionMyWorkout
    }
    
    func newWorkout () {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
        
            let uid = user.uid
        //}
            
            let docId = db.collection("users").document(uid).collection(nameMyWorkout).document()
            let db = db.collection("users").document(uid)
                .collection(nameMyWorkout).document().setData([
                    
                    "idUser" : uid,
                    "idUser" : docId,
                    "Name Workout" : nameMyWorkout,
                    "Description" : descriptionMyWorkout,
                    "TimesTramp" : FieldValue.serverTimestamp(),
                    
                                ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
            }
            
        print("test func newTraining...\(db)")
    }
    }
    
    func setupTableView () {
        
        //dataSource.data = [Any]()
        
        let cardTitleMyWorkout = ModelTitleMyWorkout(delegate: self, navigationController: self.navigationController, imageWorkout: " " , titleMyWorkout: "MY Workout" )
        
        let cardMyWorkout = ModelMyWorkout(delegate: self, navigationController: self.navigationController, nameTitleMyWorkout: nameTitleMyWorkout, nameMyWorkout: nameMyWorkout, descriptionMyWorkout: descriptionMyWorkout )
        
        dataSource.data.append(cardTitleMyWorkout)
        
        dataSource.data.append(cardMyWorkout)
        
        dataSource.initializeTableView(tableView: tableViewWorkout)
        
        tableViewWorkout.allowsSelection = false
        
        tableViewWorkout.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableViewWorkout.reloadData()
        
                
    }
    
    
}
