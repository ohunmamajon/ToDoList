//
//  Item.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/06/17.
//

import Foundation
import RealmSwift
 
class Item: Object {
   @objc dynamic var title: String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
