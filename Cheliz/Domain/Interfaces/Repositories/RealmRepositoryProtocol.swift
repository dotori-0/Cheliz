//
//  RealmRepositoryProtocol.swift
//  Cheliz
//
//  Created by SC on 3/5/25.
//

import Foundation
import RealmSwift

protocol RealmRepositoryProtocol {
    func fetch() -> Results<Media>
    func add(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void)
    func delete(media: Media, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void)
//    func sort(by sortingOrder: SortingOrder) -> Results<Media>
    func sortAndFilter() -> Results<Media>?
    func toggleWatched(of media: Media, errorHandler: @escaping () -> Void)
    func sameMediaExists(as selectedMedia: Media) -> Bool
}
