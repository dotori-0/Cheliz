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
    @Persisted var registerDate: Date     // 등록일(필수)
    @Persisted var mediaID: ObjectId
    @Persisted var TMDBid: Int  //  추가?
    @Persisted var title: String
    @Persisted var watchedDate: Date
    @Persisted var rate: Double?
    @Persisted var watchedWith: List<Person>
    @Persisted var comment: String?

    convenience init(mediaID: ObjectId,
                     TMDBid: Int,
                     title: String,
                     watchedDate: Date) {
//                     watchedWith: List<Person> = List<Person>()) {
        self.init()
        self.registerDate = Date.now
        self.mediaID = mediaID
        self.TMDBid = TMDBid
        self.title = title
        self.watchedDate = watchedDate
//        self.rate
//        self.watchedWith = watchedWith
//        self.comment = comment
    }
}
