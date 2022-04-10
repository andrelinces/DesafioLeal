//
//  AccountController.swift
//  DesafioLeal
//
//  Created by Andre Linces on 25/03/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift


class AccountController: UIViewController {
    
    @IBOutlet weak var buttonSingIN: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    
    
    var db = Firestore.firestore()
    
    var auth = Auth.auth()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("test...")
        //simpleQueries()
        //getMultiple()
        //setDocument()
        //setUser()
        getCollection()
        //listenForUsers()
        //listenForUsersFoldersIds()
        //setSubcollection()
        //setExercisesSubcollection()
        //setCategoriesSubcollection()
        //setNewCategoriesSubcollection()
        listCollection()
        //getUpdateCollection()
        //getUpdate2()
        //userCreate()
        //setDocument2()
        //newDocument()
        //retrieveObjetct()
        //retrieveObjetctCategories()
        //getMapDocument()
        
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
                "user": "Andre",
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
    
    func deleteCollection () {
        
        
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
    
     func setExercisesSubcollection() {
            
        // [START subcollection_reference]
                let exercisesRef = db
                    .collection("Exercises").document("Categories")
                    .setData([
                        "Legs" : "Legs", 
                        "chest" : "chest"
                            ])
                // [END subcollection_reference]
        print("Document successfully written!")
        print("Exercises categories: \(exercisesRef)")
    }
    
    
    //let exercicesRef = db.collection("Exercices").document("Categories")
    private func setCategoriesSubcollection() {
        let categoriesRef = db.collection("Exercises").document("Categories")
        //let categoriesRef = db.collection("Exercises").document("Categories").collection("Legs").document()
        // [START subcollection_reference]
        let categoriesID = categoriesRef.documentID
        categoriesRef.collection("Legs").document().setData([
            
            "name" : "weight squat",
            "urlImage" : "https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22",
            "observation" : "Define the belly; Increase muscle mass in the thighs; Strengthen the back; Decrease cellulite on the buttocks and legs."
                                                            ])
        
//        let categoriesID = categoriesRef.documentID
//            categoriesRef.collection(categoriesID).document().collection("Squat").document("weight squat").setData([
//
//            "name" : "weight squat",
//            "urlImage" : "https://firebasestorage.googleapis.com/v0/b/desafioleal.appspot.com/o/musculacaoPoster.jpeg?alt=media&token=f3d3e29c-f450-444a-a373-e8b8a930aa22",
//            "observation" : "Define the belly; Increase muscle mass in the thighs; Strengthen the back; Decrease cellulite on the buttocks and legs."
//
//                            ])
                // [END subcollection_reference]
        print("Document successfully written!")
        print("Exercises categories: \(categoriesRef)")
        let idExercisesCategories = categoriesRef.documentID
        print("Id exercises... \(idExercisesCategories)")
        //Exercises/Categories/Categories/0VSZrOqmGs97Olp8vsyG/Squat/weight squat
    }
    
    private func listCollection() {
        let listExercisesRef = db.document("/Exercises/Categories/Categories/I8WDClgmP8E0P9IVQcju")
    
        let listTest = db.collection("Exercises").document("Categories").collection("Legs")
        
        //listTest.whereField("Legs", in: ["Legs"])
        let idTest =  listTest.document().documentID
        
        //checking IdlistExercises
        listTest.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    //let test = document.data(as: exercisesCategories.self)
                    
                    var x : exercisesCategories? = nil
                    
                    do {
                        
                        x = try document.data(as: exercisesCategories.self)
                    }catch {
                        
                        print("error listCollection \(error)")
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
                    
                    print ("Test list exercises.. \(x?.name)")
                }
            }
        }
        
        print("Test list exercises... \(listTest) => \(listTest)")
        print("Test Id.. \(idTest)")
            // [END get_collection]
        }
    private func retrieveObjetct () {
        
    let docRef = db.collection("cities").document("LA")

        docRef.getDocument(as: City.self) { result  in
        // The Result type encapsulates deserialization errors or
        // successful deserialization, and can be handled as follows:
        //
        //      Result
        //        /\
        //   Error  City
        switch result {
        case .success(let city):
            // A `City` value was successfully initialized from the DocumentSnapshot.
            print("City: \(city)")
            
        case .failure(let error):
            // A `City` value could not be initialized from the DocumentSnapshot.
            print("Error decoding city: \(error)")
        }
            
    }
    }
    
    private func retrieveObjetctCategories () {
        //Exercises/eeFBb2y43ZgElUh6Powy/Legs
        let docRef = db.collection("Exercises").document()
        
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
            
        case .failure(let error):
            // A `City` value could not be initialized from the DocumentSnapshot.
            print("Error decoding city: \(error)")
        }
            
    }
    }
    
//    private func setDocumentWithCodable() {
//            // [START set_document_codable]
//            let city = City(name: "Los Angeles",
//                            state: "CA",
//                            country: "USA",
//                            isCapital: false,
//                            population: 5000000)
//
//            do {
//                try db.collection("cities").document("LA").setData(from: city)
//            } catch let error {
//                print("Error writing city to Firestore: \(error)")
//            }
//            // [END set_document_codable]
//        }
    
    private func setNewCategoriesSubcollection() {
        let categoriesRef = db.collection("Exercises").document()
        //let categoriesRef = db.collection("Exercises").document("Categories").collection("Legs").document()
        // [START subcollection_reference]
        let categoriesID = categoriesRef.documentID
        categoriesRef.collection("Legs").document().setData([
            
            "name" : "weight squat",
            "urlImage" : "test",
            "observation" : "Define the belly..."
                                                            ])
      
                // [END subcollection_reference]
        print("Document successfully written!")
        print("Exercises categories: \(categoriesRef)")
        let idExercisesCategories = categoriesRef.documentID
        print("Id exercises... \(idExercisesCategories)")
        //Exercises/Categories/Categories/0VSZrOqmGs97Olp8vsyG/Squat/weight squat
    }

    
    
    private func getCollection()  {
            // [START get_collection]
            db.collection("Exercises").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("Print get Collection..\(document.documentID) => \(document.data())")
                        let list = document.data()
                        
                    }
                    
                }
            }
            // [END get_collection]
        }
    
//    func listExercises(completionHandler:@escaping(String, String, String)->())  {
//
//        db.collection("Exercises").document().getDocuments { (document, error) in
//            if error == nil {
//                if document != nil && document!.exists{
//                    self.headline1 = document?.get("Headline").map(String.init(describing:)) ?? nil
//                    var article = document?.get("Article").map(String.init(describing:)) ?? nil
//                    var image1URL = URL(string: document?.get("Image") as! String)
//                    completionHandler (headline1, article, image1URL)
//                }
//            }
//        }
//
//    }
    
//    private func getMapDocument () {
//    let docRef = db.collection("Exercises").document()
//
//    // Force the SDK to fetch the document from the cache. Could also specify
//    // FirestoreSource.server or FirestoreSource.default.
//        docRef.getDocument(source: .server) { (document, error) in
//      if let document = document {
//        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//        print("Cached document data: \(dataDescription)")
//      } else {
//        print("Document does not exist in cache")
//      }
//    }
//    }
    
    private func getUpdate2 () {
        //test/APN2YyMoc3pkx7dHpC1N
        //Exercises/eeFBb2y43ZgElUh6Powy/Legs/J7SsNtdoFgTPoV2Al5JR
        //Exercises/Categories/Legs/Xa4pmUylRr44Kkwav6Do
        let usaRef = db.collection("Exercises").document("Categories").collection("Legs").document("Xa4pmUylRr44Kkwav6Do")
        //
        //        // Set the "country" field of the city 'LA' for to United States
                usaRef.updateData([
                    "name": "Successufully Weight Squat!!!"
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                 //    [END get_collection]
        
        
    }
    
    
    private func getUpdateCollection() {
            // [START get_collection]
            
        
        
        //let idTestUpdate =  db.collection("Exercises").document("Categories").collection("Legs").document().documentID
        let listTestUpdate = db.collection("/Exercises/RH72xkD8Pp8iqznLh5kf/Categories/Legs").document()
        let idTestUpdate =  listTestUpdate.documentID
        
        listTestUpdate.updateData ([

            "name" : "weight Test 1"

                                 ])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            print("Test IdTestUpdate: \(idTestUpdate)")
            }
        
//        let usaRef = db.collection("cities").document("LA")
//
//        // Set the "country" field of the city 'LA' for to United States
//        usaRef.updateData([
//            "country": "United States"
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
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
    
    // [START codable_struct]
    public struct City: Codable {

        let name: String
        let state: String?
        let country: String?
        let isCapital: Bool?
        let population: Int64?

        enum CodingKeys: String, CodingKey {
            case name
            case state
            case country
            case isCapital = "capital"
            case population
        }

    }
    // [END codable_struct]
    
    // [START codable_struct]
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
        let urlImage: String?
        let description: String?
        

        enum CodingKeys: String, CodingKey {
            case name
            case urlImage
            case description
            
        }

    }
    
    // [END codable_struct]
    
}// [END class AccountController]


