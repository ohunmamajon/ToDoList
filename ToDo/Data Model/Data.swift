//
//  Data.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/05/08.
//

import Foundation
import RealmSwift

class Data: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var age: Int = 0
}
