//
//  Protocol.swift
//  DesafioLeal
//
//  Created by Andre Linces on 01/04/22.
//

import UIKit

//Defines which method will be used for to tableview.
protocol tableViewCompatible {
    
    var reuseIdentifier : String {get}
    
    func cellForTableView ( tableView: UITableView, atIndexpath indexpath: IndexPath ) -> UITableViewCell

}
//protocol menuList {
//
//    func UIMenuBuilder()
//
//    var system: UIMenuSystem { get }
    
//    func menu(for identifier: UIMenu.Identifier) -> UIMenu? {
//        <#code#>
//    }
//    
//    func action(for identifier: UIAction.Identifier) -> UIAction? {
//        <#code#>
//    }
//    
//    func __command(forAction action: Selector, propertyList: Any?) -> UICommand? {
//        <#code#>
//    }
//    
//    func replace(menu replacedIdentifier: UIMenu.Identifier, with replacementMenu: UIMenu) {
//        <#code#>
//    }
//    
//    func replaceChildren(ofMenu parentIdentifier: UIMenu.Identifier, from childrenBlock: ([UIMenuElement]) -> [UIMenuElement]) {
//        <#code#>
//    }
//    
//    func insertSibling(_ siblingMenu: UIMenu, beforeMenu siblingIdentifier: UIMenu.Identifier) {
//        <#code#>
//    }
//    
//    func insertSibling(_ siblingMenu: UIMenu, afterMenu siblingIdentifier: UIMenu.Identifier) {
//        <#code#>
//    }
//    
//    func insertChild(_ childMenu: UIMenu, atStartOfMenu parentIdentifier: UIMenu.Identifier) {
//        <#code#>
//    }
//    
//    func insertChild(_ childMenu: UIMenu, atEndOfMenu parentIdentifier: UIMenu.Identifier) {
//        <#code#>
//    }
//    
//    func remove(menu removedIdentifier: UIMenu.Identifier) {
//        <#code#>
//    }
        
    
    

