//
//  MediaRepository.swift
//  Cheliz
//
//  Created by SC on 2022/09/18.
//

import Foundation
import RealmSwift

fileprivate protocol RealmProtocol {
    func fetch() -> Results<Media>
}

struct MediaRepository: RealmProtocol {
    let realm = try! Realm()
    
    func fetch() -> Results<Media> {
        return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
    }
}
