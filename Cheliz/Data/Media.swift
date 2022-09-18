//
//  Media.swift
//  Cheliz
//
//  Created by SC on 2022/09/18.
//

import Foundation
import RealmSwift

final class Media: Object {
    @Persisted(primaryKey: true) var id: ObjectId  // TMDB IDs: IDs are only unique within their own namespace 이기 때문에 id를 따로 구현
    @Persisted var registerDate: Date
    @Persisted var TMDBid: Int            // TMDB ID(필수)
    @Persisted var title: String          // 제목(필수)
    @Persisted var mediaType: String      // 미디어 타입(movie/tv)(필수)  // 👻 Enum으로 바꾸기
//    @Persisted var genreIds: List<Int>  // 장르 ID 배열 // 추후 구현
    @Persisted var releaseDate: String    // 개봉일(필수)
    @Persisted var backdropPath: String?  // backdrop 이미지 path(옵셔널)
    @Persisted var posterPath: String?    // poster 이미지 path(옵셔널)
    
    convenience init(TMDBid: Int, title: String, mediaType: String, backdropPath: String?, posterPath: String?, releaseDate: String) {
        self.init()
        self.registerDate = Date.now
        self.TMDBid = TMDBid
        self.title = title
        self.mediaType = mediaType
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
}
