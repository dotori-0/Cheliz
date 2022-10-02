//
//  Person.swift
//  Cheliz
//
//  Created by SC on 2022/09/27.
//

import Foundation
import RealmSwift

final class Person: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var timesWatchedTogether: Int
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.timesWatchedTogether = 0
    }
}
