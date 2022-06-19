//
//  Category.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/06/17.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
