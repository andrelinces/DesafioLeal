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
    }


