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
//    func sort(by sortingOrder: SortingOrder) -> Results<Media>
    func sortAndFilter() -> Results<Media>?
    func toggleWatched(of media: Media, errorHandler: @escaping () -> Void)
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
    
//    func sort(by sortingOrder: SortingOrder) -> Results<Media> {  // 👻 SortingOrder는 UserDefaults에 저장해도 될지?
    func sortAndFilter() -> Results<Media>? {
        let sortingOrder: SortingOrder = SortingOrder(rawValue: UserDefaultsHelper.standard.sortingOrder) ?? .oldestToNewest
        
        var media: Results<Media>?
        
        switch sortingOrder {
            case .oldestToNewest:
//                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
                media = realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
            case .newestToOldest:
//                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: false)
                media = realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: false)
            case .alphabetical:
//                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: true)
                media = realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: true)
            case .reverseAlphabetical:
//                return realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: false)
                media = realm.objects(Media.self).sorted(byKeyPath: RealmKey.title, ascending: false)
        }
        
        guard let media = media else {
            print("정렬에 실패했습니다.")  // 👻 alert 띄워 주기
            return nil
        }

        
        let filterOption: FilterOption = FilterOption(rawValue: UserDefaultsHelper.standard.filterOption) ?? .showWatched
        
        switch filterOption {
            case .showWatched:
                return media
            case .hideWatched:
                return media.where { $0.watched == false }
        }
    }
    
//    func filter(by filterOption: FilterOption) -> Results<Media> {
//        switch filterOption {
//            case .showWatched:
//                print(fetch())
//                return fetch()
//            case .hideWatched:
//                print(fetch())
////                return fetch().where { !($0.watched) }  // Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Unable to parse the format string "watched"'
//                // You can use Swift comparison operators with the Realm Swift Query API (==, !=, >, >=, <, <=).
//                return fetch().where { $0.watched == false }
//        }
//    }
    
    func toggleWatched(of media: Media, errorHandler: @escaping () -> Void) {
        do {
            try realm.write {
                media.watched.toggle()
            }
        } catch {
            print(error)
            errorHandler()
        }
    }
    
    func sameMediaExists(as selectedMedia: Media) -> Bool {
        let existingMedia = fetch().where {
            $0.mediaType == selectedMedia.mediaType &&
            $0.TMDBid == selectedMedia.TMDBid
        }
        
        return !existingMedia.isEmpty
    }
}
