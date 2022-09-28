//
//  Media.swift
//  Cheliz
//
//  Created by SC on 2022/09/18.
//

import Foundation
import RealmSwift

final class Media: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId  // TMDB IDs: IDs are only unique within their own namespace -> id 따로 구현
    @Persisted var registerDate: Date
    @Persisted var TMDBid: Int            // TMDB ID(필수)
    @Persisted var title: String          // 제목(필수)
    @Persisted var mediaType: Int      // 미디어 타입(movie/tv)(필수)    // 👻 Int로 바꾸기
    @Persisted var genreIds: List<Int>    // 장르 ID 배열                 // 추후 구현
    @Persisted var releaseDate: String    // 개봉일(필수)
    @Persisted var backdropPath: String?  // backdrop 이미지 path(옵셔널)  // 나라마다 다름
    @Persisted var posterPath: String?    // poster 이미지 path(옵셔널)    // 나라마다 다름
    @Persisted var watched: Bool          // 시청 여부(필수)
    @Persisted var watchCount: Int        // 시청 횟수(필수)               // 추후 구현
    @Persisted var rate: Double?
    @Persisted var records: List<Record>
    @Persisted var notes: String?
    
    convenience init(TMDBid: Int,
                     title: String,
                     mediaType: Int,
                     genreIds: List<Int>,
                     releaseDate: String,
                     backdropPath: String?,
                     posterPath: String?) {
        self.init()
        self.registerDate = Date.now
        self.TMDBid = TMDBid
        self.title = title
        self.mediaType = mediaType
        self.genreIds = genreIds
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.watched = false
        self.watchCount = 0
//        self.rate
        self.records = List<Record>()  // 주석처리?
//        self.notes
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(registerDate, forKey: .registerDate)
        try container.encode(TMDBid, forKey: .TMDBid)
        try container.encode(title, forKey: .title)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(Array(genreIds), forKey: .genreIds)
        try container.encode(releaseDate, forKey: .releaseDate)
        // ParsingManager에서 .stringValue가 아니라 .string으로 디코딩하면 null(nil)이 되는데,
        // encodeIfPresent로 인코딩하면 아예 인코딩이 안 됨
        // encode로 하면 null로 인코딩됨
        try container.encode(backdropPath, forKey: .backdropPath)
//        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)  // null로 처리되지 않고 ""로 처리됨
//        try container.encodeNil(forKey: .backdropPath)  // 전부 null 처리됨
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(watched, forKey: .watched)
        try container.encode(watchCount, forKey: .watchCount)
        try container.encode(rate, forKey: .rate)
        try container.encode(Array(records), forKey: .records)
        try container.encode(notes, forKey: .notes)
    }
}




//final class Media: Object, Codable {
//    @Persisted(primaryKey: true) var id: ObjectId  // TMDB IDs: IDs are only unique within their own namespace -> id 따로 구현
//    @Persisted var registerDate: Date
//    @Persisted var TMDBid: Int            // TMDB ID(필수)
//    @Persisted var title: String          // 제목(필수)
//    @Persisted var mediaType: String      // 미디어 타입(movie/tv)(필수)    // 👻 Int로 바꾸기
//    @Persisted var genreIds: List<Int>    // 장르 ID 배열                 // 추후 구현
//    @Persisted var releaseDate: String    // 개봉일(필수)
//    @Persisted var backdropPath: String?  // backdrop 이미지 path(옵셔널)  // 나라마다 다름
//    @Persisted var posterPath: String?    // poster 이미지 path(옵셔널)    // 나라마다 다름
//    @Persisted var watched: Bool          // 시청 여부(필수)
//    @Persisted var watchCount: Int        // 시청 횟수(필수)               // 추후 구현
//
//    convenience init(TMDBid: Int, title: String, genreIds: List<Int>, mediaType: String, backdropPath: String?, posterPath: String?, releaseDate: String) {
//        self.init()
//        self.registerDate = Date.now
//        self.TMDBid = TMDBid
//        self.title = title
//        self.genreIds = genreIds
//        self.mediaType = mediaType
//        self.releaseDate = releaseDate
//        self.backdropPath = backdropPath
//        self.posterPath = posterPath
//        self.watched = false
//        self.watchCount = 0
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(registerDate, forKey: .registerDate)
//        try container.encode(TMDBid, forKey: .TMDBid)
//        try container.encode(title, forKey: .title)
//        try container.encode(mediaType, forKey: .mediaType)
//        let genreIds = Array(genreIds)
//        try container.encode(genreIds, forKey: .genreIds)
//        try container.encode(releaseDate, forKey: .releaseDate)
//
//        // ParsingManager에서 .stringValue가 아니라 .string으로 디코딩하면 null(nil)이 되는데,
//        // encodeIfPresent로 인코딩하면 아예 인코딩이 안 됨
//        // encode로 하면 null로 인코딩됨
//        try container.encode(backdropPath, forKey: .backdropPath)
////        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)  // null로 처리되지 않고 ""로 처리됨
////        try container.encodeNil(forKey: .backdropPath)  // 전부 null 처리됨
//        try container.encode(posterPath, forKey: .posterPath)
//        try container.encode(watched, forKey: .watched)
//        try container.encode(watchCount, forKey: .watchCount)
//    }
//}
