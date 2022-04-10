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
    
    func actionClickCardView(indexPath: IndexPath) {
       // print("clicou no card\(indexPath.row)")
        
        
        let user = Auth.auth().currentUser
        
//                                if let user == nil {
//
//                                    let uid = user.uid
//                                }
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
      }
    
    func setTitleDisplay(_ user: User?) {
        if let name = user?.displayName {
          navigationItem.title = "Welcome \(name)"
        } else {
          navigationItem.title = "Authentication Example"
        }
      }
    
    func actionReturn() {
        print("Teste voltar : \(navigationController)")
        navigationController?.popViewController(animated: true)
    }
    
    //var auth = Auth.auth().currentUser?.uid
    
    //var db = Firestore.firestore()
    
    let dataSource = DataSource()
    
    @IBOutlet weak var tableViewExercises: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        //print("test auth...\(auth)")
        //singIn()
        //newWorkout()
        //actionReturn()
        setupTableview2()
        //setupTableView()
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

    
    func newWorkout () {
        
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

    func singIn () {
        
        Auth.auth().signIn(withEmail: "joetest@gmail.com", password: "123456") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
        }
    }
    
    
    func saveExercises () {

         // listTest <-- If this is made an array literal, everything works

            
        let listTest = db.collection("Exercises").document("Categories").collection("Legs")
        
        let idTest =  listTest.document().documentID
    
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
                    
                    
                    
                    
                    let cardExercisesPoster = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: imageExercisesPoster ?? "Url", exercisesTitle: exercisesTitle ?? "Url", observation: observation ?? "Url" )
                    
                    //let cardExercisesTitle = ModelExercisesTitle(delegate: self, navigationController: self.navigationController, exercisesTitle: "Exercises")

                   // self.dataSource.data.append(cardExercisesTitle)

                    self.dataSource.data.append(cardExercisesPoster)

                    self.tableViewExercises.reloadData()
                    
                }
            }
        }





    }
    
    
    //var scheduleIDarray = [String : Any] ()
//    func loadData() {
//                    db.collection("Exercises").getDocuments() { (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        } else {
//                            for document in querySnapshot!.documents {
//
//                                self.scheduleIDarray.append(document.documentID)
//
//                            }
//                        }
//                        print(self.scheduleIDarray) // <-- This prints the content in db correctly
//                    }
//                }
    var listExercises = [String : Any] ()
//    func setuptableView2 () {
//
//
//                        db.collection("Exercises").getDocuments() { (querySnapshot, err) in
//                            if let err = err {
//                                print("Error getting documents: \(err)")
//                            } else {
//                                for document in querySnapshot!.documents {
//
//                                    self.listExercises = document.data()
//
//                                    let imageExercisesPoster = listExercises.urlImage
//                                                    let exercisesTitle = listExercises.name
//                                                    let observation = listExercises.observation
//
//                                }
//                            }
//                            print(self.scheduleIDarray) // <-- This prints the content in db correctly
//                        }
//
//
//    }
    
    func setupTableview2 () {
        
        
           // let listExercisesRef = db.document("/Exercises/Categories/Categories/I8WDClgmP8E0P9IVQcju")
        
            let listTest = db.collection("Exercises").document("Categories").collection("Legs")
            
            //listTest.whereField("Legs", in: ["Legs"])
            let idTest =  listTest.document().documentID
        
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
                
    //                    //let test = document.documentID
    //                    print (" test id exercises... \(test)")
    //
    //                    for listExercises in test {
    //
    //                       var resExercises = test.count
    //                        print ("list exercises... \(test.keys)")
    //                    }
    //                    print ("list exercises... \(test.count)")
    //                    print ("list exercises... \(test.description)")
                        
                        print ("Test list exercises.. \(listExercises?.name)")
                        print ("test observation... \(listExercises?.observation)")
                        let imageExercisesPoster = listExercises?.urlImage
                        let exercisesTitle = listExercises?.name
                        let observation = listExercises?.observation
                //var scheduleIDarray = [String] ()
                        let id = document.documentID
                        
                        let cardExercisesPoster = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: imageExercisesPoster ?? "Url", exercisesTitle: exercisesTitle ?? "Url", observation: observation ?? "Url" )
                        
                        //let cardExercisesTitle = ModelExercisesTitle(delegate: self, navigationController: self.navigationController, exercisesTitle: "Exercises")

                       // self.dataSource.data.append(cardExercisesTitle)

                        self.dataSource.data.append(cardExercisesPoster)

                        self.tableViewExercises.reloadData()
                        
                    }
                }
            }
        
        dataSource.initializeTableView(tableView: tableViewExercises)

        tableViewExercises.allowsSelection = false

        tableViewExercises.separatorStyle = UITableViewCell.SeparatorStyle.none
            print("Test list exercises... \(listTest) => \(listTest)")
            print("Test Id.. \(idTest)")
                // [END get_collection]
        
            }
        
        
    func setupTableView () {

         //func retrieveObjetctCategories () {
            //Exercises/eeFBb2y43ZgElUh6Powy/Legs
            let docRef = db.collection("Exercises").document("leg")

            docRef.getDocument(as: exercisesCategories.self) { result  in
            // The Result type encapsulates deserialization errors or
            // successful deserialization, and can be handled as follows:
            //
            //      Result
            //        /\
            //   Error  City
            switch result {
            case .success(let exeCategories):
                // A `City` value was successfully initialized from the DocumentSnapshot.
                print("Categories: \(exeCategories)")

                //let list = exeCategories
                //for listExercises in exeCategories {

                let imageExercisesPoster = exeCategories.urlImage
                let exercisesTitle = exeCategories.name
                let observation = exeCategories.observation
                
        //var scheduleIDarray = [String] ()
                
                
                let cardExercisesPoster = ModelExercisesPoster(delegate: self, navigationController: self.navigationController, imageExercisesPoster: imageExercisesPoster ?? "Url", exercisesTitle: exercisesTitle ?? "Url", observation: observation ?? "Url" )

                self.dataSource.data.append(cardExercisesPoster)

                self.tableViewExercises.reloadData()
                
                //}
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding city: \(error)")
            }

                
                
        }


        //let cardExercisesPoster = ModelExercisesPoster(delegate: self, navigationController: navigationController, imageExercisesPoster: imageExercisesPoster, exercisesTitle: exercisesTitle, observation: observation )
       // let segundaCelulaModel = PrimeiraCelulaModel(delegate: self, tituloCard: "Segunda")

        let cardExercisesTitle = ModelExercisesTitle(delegate: self, navigationController: navigationController, exercisesTitle: "Exercises")

            dataSource.data.append(cardExercisesTitle)



        dataSource.initializeTableView(tableView: tableViewExercises)

        tableViewExercises.allowsSelection = false

        tableViewExercises.separatorStyle = UITableViewCell.SeparatorStyle.none

        
    }//[end setupTableView]
    
//gs://desafioleal.appspot.com/musculacaoPoster.jpeg
//https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22
    
}
//ExerciciesTest
//NameChoiceUser
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
    

    enum CodingKeys: String, CodingKey {
        case name
        case days
        case timesTramp
        case idWorkout
    }

}
