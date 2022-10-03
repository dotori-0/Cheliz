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
    func sameMediaExists(as selectedMedia: Media) -> Bool
}

struct MediaRepository: RealmProtocol {
    let realm = try! Realm()
    
    // MARK: - Media
    func fetch() -> Results<Media> {
//        return realm.objects(Media.self).sorted(byKeyPath: RealmKey.registerDate, ascending: true)
        return realm.objects(Media.self)
    }
    
    func add(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        do {
            try realm.write {
                realm.add(media)
//                completionHandler()  // 여기에서 해야 하는지? -> 어디서 하든 상관은 없지만 명확히 구분하기 위해 realm.write 구문 밖에서 실행
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
                deleteRecords(of: media)
                realm.delete(media)
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
//                media.watchCount = media.watchCount == 0 ? 1 : 0
            }
        } catch {
            print(error)
            errorHandler()
        }
    }
    
    func changeWatchCount(of media: Media, to count: Int, errorHandler: @escaping() -> Void) {
        do {
            try realm.write {
                media.watchCount = count
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
    
    
//    func encode<Media: Encodable>(_ media: Media) throws -> Data {
//        let encoder = JSONEncoder()
//        return try encoder.encode(media)
//    }
    
    func encode() -> Data? {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(fetch())
            return data
//            return try encoder.encode(fetch())
        } catch {
            print(error)
        }
//        return try encoder.encode(fetch())
        
//        let data = encoder.encode(fetch())
//        return data
        
        return nil
    }
    
    func encode2() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let jsonString = try String(data: encoder.encode(fetch()), encoding: .utf8)
            return jsonString
//            return try encoder.encode(fetch())
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func replaceRealm(with mediaArray: [Media], completionHandler: @escaping () -> Void) {
        do {
            try realm.write {
                realm.deleteAll()
                realm.add(mediaArray)
            }
            completionHandler()
        } catch {
            // 👻 error handler
            print(error)
        }
    }
    
    // MARK: - Records
//    func fetchRecords(of media: Media) -> List<Record> {
    func fetchRecords(of media: Media) -> Results<Record> {
//        return realm.objects(Record.self).sorted(byKeyPath: RealmKey.watchedDate)
//        return media.records//.sorted(by: <#T##KeyPath<Record, _HasPersistedType>#>)
        return media.records.sorted(byKeyPath: RealmKey.registerDate, ascending: true)
    }
    
    func addRecord(of record: Record, to media: Media) {
        do {
            try realm.write {
                media.records.append(record)
            }
        } catch {
            print(error)  // 👻 error handler
        }
    }
    
    func deleteRecord(of record: Record, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        do {
            try realm.write {
                print("⛔️ \(record.id)")
                deletePeople(from: record)  // Person의 같이 본 횟수 - 1
                realm.delete(record)        // record를 지우면 media의 records 리스트에서도 자동으로 사라짐
            }
            completionHandler()
        } catch {
            print(error)
            errorHandler()
        }
    }
    
    func deleteRecords(of media: Media) {
        media.records.forEach { record in
            deletePeople(from: record)  // Person의 같이 본 횟수 - 1
            realm.delete(record)        // record를 지우면 media의 records 리스트에서도 자동으로 사라짐
        }
    }
    
    func add(person: Person, to record: Record) {
        print("📇 repository에서 record.id: \(record.id)")
        do {
            try realm.write {
                record.watchedWith.append(person)
                incrementTimesWatchedTogether(of: person)
            }
        } catch  {
            print(error)
        }
    }
    
    func delete(person: Person, from record: Record) {
        do {
            try realm.write {
                guard let index = record.watchedWith.firstIndex(of: person) else {
                    print("Error in finding index of person")
                    return
                }
                record.watchedWith.remove(at: index)
                decrementTimesWatchedTogetherByOne(of: person)
            }
        } catch {
            print(error)  // 👻 error handler
        }
    }

    
//    func changeDate(of record: Record, to date: Date, in media: Media) {
    func changeDate(of record: Record, to date: Date) {
        do {
            try realm.write {
                record.watchedDate = date
            }
        } catch {
            print(error)  // 👻 error handler
        }
    }
    
    func editNotes(of media: Media, to notes: String?) {
        do {
            try realm.write {
                media.notes = notes
            }
        } catch {
            print(error)  // 👻 error handler
        }
    }
    
    // MARK: - Person
    func fetchPeople() -> Results<Person> {
        return realm.objects(Person.self)
    }
    
    
    func samePersonExists(named name: String) -> Bool {
        let existingPeople = fetchPeople().where { $0.name == name }
        
        return !existingPeople.isEmpty
    }
    
    func samePersonExistsInRecord(named name: String, in record: Record) -> Bool {
        let existingPeople = record.watchedWith.where { $0.name == name }
        
        return !existingPeople.isEmpty
    }
    
    func fetchPerson(named name: String) -> Person {
        let people = fetchPeople().where { $0.name == name }
        
        guard let person = people.first else {
            print("Error in finding person with same name")
            return Person()
        }
        
        return person
    }
    
    func incrementTimesWatchedTogether(of person: Person) {
        person.timesWatchedTogether += 1
//        do {
//            try realm.write {
//                person.timesWatchedTogether += 1
//            }
//        } catch  {
//            print(error)
//            print("Error in increasing times watched together")
//            // 👻 error handler
//        }
    }
    
    func decrementTimesWatchedTogetherByOne(of person: Person) {
        if person.timesWatchedTogether != 0 { person.timesWatchedTogether -= 1 }
//        do {
//            try realm.write {
//                if person.timesWatchedTogether != 0 { person.timesWatchedTogether -= 1 }  // 👻 혹시 몰라서 예외처리...?
//            }
//        } catch  {
//            print(error)
//            print("Error in decreasing times watched together")
//            // 👻 error handler
//        }
    }
    
    func deletePeople(from record: Record) {
        record.watchedWith.forEach { person in
            print(person.name)
            decrementTimesWatchedTogetherByOne(of: person)
        }
    }
}
