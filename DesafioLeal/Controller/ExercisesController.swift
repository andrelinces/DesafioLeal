//
//  ExerciciesController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 30/03/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth



class ExercisesController: UIViewController, ModelExercisesPosterCallBack, ModelExercisesTitleCellCallBack {
    var auth = Auth.auth().currentUser?.uid
    
    var db = Firestore.firestore()
    
    func actionReturn() {
        print("Teste voltar : \(tabBarController)")
        navigationController?.popViewController(animated: true)
        
        self.tabBarController?.selectedIndex = 1
    }
    
    
    func actionClickCardView(indexPath: IndexPath) {
       // print("clicou no card\(indexPath.row)")
        
        
        let user = Auth.auth().currentUser
        
            // [Alert for to user, account created successfully]
            let alert = UIAlertController(title:  "Save Exercises", message: "Do you want add this exercise from your workout? ?", preferredStyle: .alert)
            
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { alertAction in
                //testing...
                print("confirmAction")
                   
            }
            
            alert.addAction(cancelAlert)
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
           // performSegue(withIdentifier: "segueMyWorkout" , sender: nil)
        
        
    }//[end actionCliqueCard]
    
    var handle: AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // [START_EXCLUDE]
            
            
            self.setTitleDisplay(user)
          self.tableViewExercises.reloadData()
            
           // self.performSegue(withIdentifier: "segueSingInWorkout", sender: nil)
          // [END_EXCLUDE]
        }
    }
    
    //Update from navigation controller.
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        dataSource.navigationController = nil
//    }
    
    
    
    func setTitleDisplay(_ user: User?) {
        if let name = user?.displayName {
          navigationItem.title = "Welcome \(name)"
        } else {
            navigationItem.title = user?.displayName
        }
      }
   
    
    //var auth = Auth.auth().currentUser?.uid
    
    //var db = Firestore.firestore()
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewExercises: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        setupTableview()
       
        tableViewExercises.reloadData()
        
    }
    
    var imageExercisesPoster : String = ""
    var exercisesTitle : String = ""
    var observation : String = "" 
    //var urlDetails : String = ""
    
    func initiate(imageExercisesPoster : String, exercisesTitle : String, observation : String){
        self.imageExercisesPoster = imageExercisesPoster
        self.exercisesTitle = exercisesTitle
        self.observation = observation
        //self.urlDetails = urlDetails
    }

//    func singIn () {
//        
//        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
//            
//        }
//    }
    
    func setupTableview () {
        
        dataSource.navigationController = self.navigationController
        
            let listTest = db.collection("Exercises").document("Categories").collection("Legs")
            
            //listTest.whereField("Legs", in: ["Legs"])
            let idTest =  listTest.document().documentID
        
            // [Card Exercises Title and image]
            let cardExercisesTitle = ModelExercisesTitle(delegate: self, navigationController: self.navigationController, exercisesTitle: "Exercises")
        
            self.dataSource.data.append(cardExercisesTitle)
        
            //checking IdlistExercises
            listTest.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        //let test = document.data(as: exercisesCategories.self)
                        
                        var listExercises : exercisesCategories? = nil
                        
                        do {
                            
                            listExercises = try document.data(as: exercisesCategories.self)
                        }catch {
                            
                            print("error listCollection \(err)")
                        }
 
                        
                        print ("Test list exercises.. \(listExercises?.name)")
                        print ("test observation... \(listExercises?.observation)")
                        let imageExercisesPoster = listExercises?.urlImage
                        let exercisesTitle = listExercises?.name
                        let observation = listExercises?.observation
                //var scheduleIDarray = [String] ()
                        let id = document.documentID
                        
                        // [Exercises default]
                        let cardExercisesPoster = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: imageExercisesPoster ?? "Url", exercisesTitle: exercisesTitle ?? "Url", observation: observation ?? "Url" )
                        
                        self.dataSource.data.append(cardExercisesPoster)

                        self.tableViewExercises.reloadData()
                        
                    }
                }
            }
        
        dataSource.initializeTableView(tableView: tableViewExercises)

        tableViewExercises.allowsSelection = false

        tableViewExercises.separatorStyle = UITableViewCell.SeparatorStyle.none
      
            }

}

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
    let days: String?
    let timesTramp: String?
    let idWorkout: String
    let description : String

    enum CodingKeys: String, CodingKey {
        case name
        case days
        case timesTramp
        case idWorkout
        case description
    }

}

public struct userWorkoutExercises: Codable {

    let name: String
    //let days: String?
    let imageurl: String
    let idExercises : String
    let description : String

    enum CodingKeys: String, CodingKey {
        case name
        //case days
        case imageurl
        case idExercises
        case description
    }

}
