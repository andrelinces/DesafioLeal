//
//  AccountController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 25/03/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class AccountController: UIViewController {
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("test...")
        //simpleQueries()
        //getMultiple()
        //setDocument()
        //setUser()
        getCollection()
        listenForUsers()
        listenForUsersFoldersIds()
        setSubcollection()
        //userCreate()
        //setDocument2()
        //newDocument()
        
    }
    
    private func simpleQueries() {
        print("test...")
            // [START simple_queries]
            // Create a reference to the cities collection
        let usersRef = db.collection("Users")

            // Create a query against the collection.
            let query = usersRef.whereField("name", isEqualTo: "joe")
            // [END simple_queries]
            // [START simple_query_not_equal]
            //let notEqualQuery = usersRef.whereField("capital", isNotEqualTo: false)
            // [END simple_query_not_equal]
        print("test query... \(query.description)")
        }
    private func getMultiple() {
            // [START get_multiple]
            db.collection("Users").whereField("name", isEqualTo: "Sands")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("Current user: \(document.documentID) => \(document.data())")
                        }
                    }
            }
            // [END get_multiple]
        }
    private func setDocument2() {
        let roomsCollectionRef = db.collection("Rooms")
        let messageRef = db
            .collection("Rooms").document("roomA")
            .collection("messages").document("message1")
        
        //print("Document2 successfully written! \(roomsCollectionRef)")
        print("Document2 successfully written! \(messageRef)")
        
    }
    
    private func newDocument() {
           // [START new_document]
           let newRoomRef = db.collection("Rooms").document()

           // later...
           newRoomRef.setData([
               // [START_EXCLUDE]
               "name": "Some City Name"
               // [END_EXCLUDE]
           ])
           // [END new_document]
        
       }
    
    private func setDocument() {
            // [START set_document]
            // Add a new document in collection "cities"
            db.collection("cities").document("LA").setData([
                "name": "Los Angeles",
                "state": "CA",
                "country": "USA"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            // [END set_document]
        }
    private func setUser() {
            // [START set_document]
            // Add a new document in collection "cities"
        db.collection("Users").document().setData([
                "user": "",
                "name": "TestID",
                "email": "annatest@gmail.com",
                "passaword": "1234"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            // [END set_document]
        // [START subcollection_reference]
//                let messageRef = db
//                    .collection("rooms").document("roomA")
//                    .collection("messages").document("message1")
//                // [END subcollection_reference]
//                print(messageRef)
        }
    
    private func userCreate() {
        
        // Create the user
        Auth.auth().createUser(withEmail: "testFunc2@gmail.com", password: "123456") { (result, err) in

                    // Check for errors
                    if err != nil {

                        // There was an error
                        print("Error creating the user\(err)")
                    }
                    else {
                        // User was created successfully, now store the first name and last name
                        let db = Firestore.firestore()

                        let uid = result!.user.uid
                        
//                        let messageRef = db
//                            .collection("rooms").document("roomA")
//                            .collection("messages").document("message1")

                        //creates profile doc under uid with all the info
                        db.collection("Users").document(uid).setData(["uid": uid]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                            
                            }
                        db.collection(uid)
                            .document("profile").setData([ "firstname": "test", "lastname" : "lastName" , "uid":uid]) { (error) in
                                
                                print("User and data folders, successfully created!")
                        

                            if error != nil {
                                //Show error message
                                print("Error creating the user\(error)")
                            }
                        }

                        //Transition to home
                        //self.transitionToHome()
                    }
                }
    

    
    }
    
    private func setSubcollection() {
            
        // [START subcollection_reference]
                let messageRef = db
                    .collection("Users").document("joe")
                    .collection("exercicies").document().setData([
                        "treino1" : "trainingTest" ])
                // [END subcollection_reference]
        print("Document successfully written!")
        print(messageRef)
    }
    private func getCollection() {
            // [START get_collection]
            db.collection("users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
            // [END get_collection]
        }
    
    private func listenForUsers() {
            // [START listen_for_users]
            // Listen to a query on a collection.
            //
            // We will get a first snapshot with the initial results and a new
            // snapshot each time there is a change in the results.
            db.collection("Users")
            .whereField("name", isEqualTo: "joe")
                .addSnapshotListener { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error retreiving snapshots \(error!)")
                        return
                    }
                    print("Current users name joe: \(snapshot.documents.map { $0.data() })")
                }
            // [END listen_for_users]
        }
    
    private func listenForUsersFoldersIds() {
            // [START listen_for_users]
            // Listen to a query on a collection.
            //
            // We will get a first snapshot with the initial results and a new
            // snapshot each time there is a change in the results.
        db.collection("Users").getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            //Retrieves id from the documents.
            for document in snapshot.documents {

              if document == document {
               print(document.documentID)
                 }
                   }
            let refId = snapshot
            print("Current users ids: \(snapshot.documents.map { $0.data() }  ) ")
            
        }
        // [END listen_for_users]
        }
        
            
    
//    db.collection("Users").document()
//        .addSnapshotListener { querySnapshot, error in
//                guard let snapshot = querySnapshot else {
//                    print("Error retreiving snapshots \(error!)")
//                    return
//                }
//            let refId = snapshot.documentID
//            print("Current users ids: \(refId.description  ) ")
//            }
//        // [END listen_for_users]
//            }
    
}
