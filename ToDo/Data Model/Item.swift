//
//  Data Model.swift
//  ToDo
//
//  Created by Okhunjon Mamajonov on 2022/03/06.
//

import Foundation
class Item: Encodable, Decodable {
    var title : String = ""
    var done: Bool = false
}
