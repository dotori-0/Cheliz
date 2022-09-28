//
//  Record.swift
//  Cheliz
//
//  Created by SC on 2022/09/27.
//

import Foundation
import RealmSwift

final class Record: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var watchedDate: Date
    @Persisted var rate: Double?
    @Persisted var watchedWith: List<Person>
    @Persisted var comment: String?

    convenience init(id: ObjectId,
                     watchedDate: Date,
                     watchedWith: List<Person> = List<Person>(),
                     comment: String?) {
        self.init()
        self.id = id
        self.watchedDate = watchedDate
//        self.rate
        self.watchedWith = watchedWith
        self.comment = comment
    }
}
