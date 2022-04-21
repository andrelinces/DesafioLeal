//
//  Extension.swift
//  DesafioLeal
//
//  Created by Andre Linces on 01/04/22.
//

import UIKit

extension UIView {
    
    //Defines the designer to cell model.
    func changeDesigneView(cornerRadius: CGFloat, shadow: CGSize, shadowOpacity: Float){
        self.layer.cornerRadius = cornerRadius
        
        self.layer.shadowOffset = shadow
        
        self.layer.shadowOpacity = shadowOpacity
        
    }
    
    //Modelcardview
    func borderDesigneView(cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        self.layer.shadowOpacity = 0.2
        
    }
}
    //MARK: Retrieves the Movie Image, donwload from URL of API
    extension UIImageView {
        func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
        
        // Create alert controller
//            let alertController = UIAlertController(title: "Update Name", message: "Type name for to workout!", preferredStyle: .alert)
//
//            // add textfield at index 0
//            alertController.addTextField(configurationHandler: {(_ textFieldName: UITextField) -> Void in
//                textFieldName.placeholder = "Name"
//                
//            })
//
//            // add textfield at index 1
//            alertController.addTextField(configurationHandler: {(_ textFieldCategorie: UITextField) -> Void in
//                textFieldCategorie.placeholder = "Categorie"
//
//            })
              
            // Alert action confirm
//            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
//                print("name: \(String(describing: alertController.textFields?[0].text))")
//                print("email: \(String(describing: alertController.textFields?[1].text))")
//                self.myWorkout = alertController.textFields?[0].text ?? "default test field"
//                
//                var handle: AuthStateDidChangeListenerHandle?
//                
//                if alertController.textFields?[0].text == "" || alertController.textFields?[1].text == "" {
//
//                    let alert = UIAlertController(title: "Empty field", message: "Type name or categorie for to workout!", preferredStyle: .alert)
//
//                    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
//                        print("Canelled")
//                        
//                    })
//                    alert.addAction(cancel)
//                    self.present(alert, animated: true, completion: nil)
////                        })
//                }else{
//                let userId = self.auth.currentUser?.uid
//                var refNewName = self.db.collection("users").document(userId ?? "default").collection("workout").document(userId ?? "default")
//                
//                // Set the reference for to updating document.
//                refNewName.updateData([
//                    
//                    "name": alertController.textFields?[0].text
//                    
//                ]) { err in
//                    if let err = err {
//                        print("Error updating document: \(err)")
//                    } else {
//                        print("Document successfully updated")
//                        self.tableViewWorkout.reloadData()
//                    }
//                }
//                }//[end else]
//            })
//    
//            alertController.addAction(confirmAction)
//        
//            // Alert action cancel
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//                print("Canelled")
//            
//            })
//            alertController.addAction(cancelAction)
//
//            // Present alert controller
//            present(alertController, animated: true, completion: nil)
    }


