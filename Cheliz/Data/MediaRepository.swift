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
    
    func add(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        do {
            try realm.write {
                realm.add(media)
//                completionHandler()  // 여기에서 해야 하는지?
            }
            completionHandler()
            print(fetch())
        } catch  {
            print(error)
            errorHandler()
        }
    }
}
