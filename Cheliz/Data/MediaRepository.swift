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
    func add(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void)
    func delete(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void)
    func sort(by sortingOrder: SortingOrder) -> Results<Media>
}

struct MediaRepository: RealmProtocol {
    let realm = try! Realm()
    
    func fetch() -> Results<Media> {
//        return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
        return realm.objects(Media.self)
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
    
    func delete(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        do {
            try realm.write {
                realm.delete(media)
//                completionHandler()  // 여기에서 해야 하는지?
            }
            completionHandler()
            print(fetch())
        } catch {
            print(error)
            errorHandler()
        }
    }
    
    func sort(by sortingOrder: SortingOrder) -> Results<Media> {  // 👻 SortingOrder는 UserDefaults에 저장해도 될지?
        switch sortingOrder {
            case .newestToOldest:
                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: false)
            case .oldestToNewest:
                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
            case .alphabetical:
                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: true)
            case .reverseAlphabetical:
                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: false)
        }
    }
}
