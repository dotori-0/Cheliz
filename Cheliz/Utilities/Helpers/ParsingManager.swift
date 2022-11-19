//
//  ParsingManager.swift
//  Cheliz
//
//  Created by SC on 2022/09/15.
//

import Foundation
import RealmSwift
import SwiftyJSON

struct ParsingManager {
    private init() { }
    
    /*
    // guard let
    static func parseDataGuardLet(_ data: Data) -> [MediaModel?] {
        let json = JSON(data)
        
        let mediaArray: [MediaModel?] = json["results"].arrayValue.map { result in
            guard let mediaType = MediaType(rawValue: result["media_type"].stringValue) else {
                print("Cannot find mediaType")  // 👻 얼럿 띄우기
                return nil
            }
            let title = mediaType == .movie ? result["title"].stringValue : result["name"].stringValue
            let releaseDate = mediaType == .movie ? result["release_date"].stringValue : result["first_air_date"].stringValue
            
            let mediaModel = MediaModel(title: title,
                                    mediaType: mediaType,
                                    id: result["id"].intValue,
                                    backdropPath: result["backdrop_path"].stringValue,  // 👻 null인 경우 있음
                                    posterPath: result["poster_path"].stringValue,
                                    releaseDate: releaseDate,
                                    overview: result["overview"].stringValue)
            return mediaModel
        }
        
        return mediaArray
    }
    
    // if let
    static func parseDataIfLet(_ data: Data) -> [MediaModel?] {
        let json = JSON(data)
        
        let mediaArray: [MediaModel?] = json["results"].arrayValue.map { result in
            var mediaModel: MediaModel?
            
            if let mediaType = MediaType(rawValue: result["media_type"].stringValue) {
                let title = mediaType == .movie ? result["title"].stringValue : result["name"].stringValue
                let releaseDate = mediaType == .movie ? result["release_date"].stringValue : result["first_air_date"].stringValue
                
                mediaModel = MediaModel(title: title,
                                        mediaType: mediaType,
                                        id: result["id"].intValue,
                                        backdropPath: result["backdrop_path"].stringValue,  // 👻 null인 경우 있음
                                        posterPath: result["poster_path"].stringValue,
                                        releaseDate: releaseDate,
                                        overview: result["overview"].stringValue)
            }
            
            return mediaModel
        }
        
        return mediaArray
    }
    
    static func parseData(_ data: Data) -> [MediaModel] {
        let json = JSON(data)
//        print("🐶", json)
        
        let JSONMovieAndTvOnly: [JSON] = json["results"].arrayValue.filter { $0["media_type"].stringValue != "person" }
//        print("🐱", JSONMovieAndTvOnly)
        
        let mediaArray: [MediaModel] = JSONMovieAndTvOnly.map { result in
            let mediaType: MediaType = result["media_type"].stringValue == "movie" ? .movie : .tv
            let title = mediaType == .movie ? result["title"].stringValue : result["name"].stringValue
            let releaseDate = mediaType == .movie ? result["release_date"].stringValue : result["first_air_date"].stringValue
            
            let mediaModel = MediaModel(title: title,
                                    mediaType: mediaType,
                                    id: result["id"].intValue,
                                    backdropPath: result["backdrop_path"].stringValue,  // 👻 null인 경우 있음
                                    posterPath: result["poster_path"].stringValue,
                                    releaseDate: releaseDate,
                                    overview: result["overview"].stringValue)
            
            return mediaModel
        }
        
        return mediaArray
    }
    */
        
//        static func parseDataToRealmModel(_ data: Data) -> [Media] {
        static func parseDataToRealmModel(_ data: Data) -> ([Media], Int) {
            let json = JSON(data)
    //        print("🐶", json)
            
            let JSONMovieAndTvOnly: [JSON] = json["results"].arrayValue.filter { $0["media_type"].stringValue != "person" }
    //        print("🐱", JSONMovieAndTvOnly)
            
            let mediaArray: [Media] = JSONMovieAndTvOnly.map { result in
                let mediaType = result["media_type"].stringValue == MediaType.movie.string ? MediaType.movie.rawValue : MediaType.tv.rawValue
//                let title = mediaType == "movie" ? result["title"].stringValue : result["name"].stringValue
//                let title = mediaType == MediaType.movie.rawValue ? result["title"].stringValue : result["name"].stringValue
                let title = result[mediaType == MediaType.movie.rawValue ? "title" : "name"].stringValue
                
                let genreIds = List<Int>()
//                if let genreIdsArray = result["genre_ids"].arrayValue as? [Int] {
//                    genreIds.append(objectsIn: genreIdsArray)
//                }
                let genreIdsArray = result["genre_ids"].arrayValue.map { $0.intValue }
                genreIds.append(objectsIn: genreIdsArray)
                
                let overview = result["overview"].string
                
//                let releaseDate = mediaType == "movie" ? result["release_date"].stringValue : result["first_air_date"].stringValue
                let releaseDate = result[mediaType == MediaType.movie.rawValue ? "release_date" : "first_air_date"].stringValue
                
                let mediaRealmModel = Media(TMDBid: result["id"].intValue,
                                            title: title,
                                            mediaType: mediaType,
                                            genreIds: genreIds,
                                            overview: overview,
                                            releaseDate: releaseDate,
                                            backdropPath: result["backdrop_path"].string,
                                            posterPath: result["poster_path"].string)
                
    //            return mediaModel
                return mediaRealmModel
            }
            
            let totalPages = json["total_pages"].intValue
        
//        return mediaArray
        return (mediaArray, totalPages)
    }
    
    static func parseDetails(_ data: Data) -> (Int?, String?) {
        // runtime, overview
        let json = JSON(data)
        
        let runtime = json["runtime"].int       // runtime: integer or null
        let overview = json["overview"].string  // overview: string or null

        return (runtime, overview)
    }
    
    static func parseDetails2(_ data: Data) -> Int? {
        // runtime, overview
        let json = JSON(data)
        
        let runtime = json["runtime"].int       // runtime: integer or null

        return runtime
    }
    
    // 👻 한 언어로 한 번 장르를 받아오면 userdefaults에 저장할 수 있도록 구현하기
    static func parseGenres(_ data: Data) -> [Int: String] {
        let json = JSON(data)
        
//        let genres: [Int: String] = json["genres"].arrayValue.map {
//            $0["id"].intValue: $0["name"].stringValue
//            Dictionary(<#T##S#>, uniquingKeysWith: <#T##(Value, Value) -> Value#>)
//
//        }
        
//        {
//            "id": 28,
//            "name": "액션"
//        },
        
        let genres = json["genres"].arrayValue.reduce(into: [Int: String]()) { // partialResult, <#JSON#> in
            $0[$1["id"].intValue] =  $1["name"].stringValue
        }
        
        return genres
    }
    
    static func parseCredits(_ data: Data) -> [[Credit]] {
        let json = JSON(data)
        let crewArray = json["crew"].arrayValue
        let castArray = json["cast"].arrayValue
        
        
        // movie - "job": "Director"
        // tv - "job": "Executive Producer" -> X
        
        let directorsArray = crewArray.filter {
            $0["job"].stringValue == "Director"
        }  // could be [] if tv
        
        let directors: [Credit] = directorsArray.map {
            let profilePath = $0["profile_path"].string
            let name = $0["name"].stringValue
            let job = $0["job"].stringValue
            
            return Credit(profilePath: profilePath, name: name, character: job)
        }  // could be [] if tv
        
        let cast: [Credit] = castArray.map {
            let profilePath = $0["profile_path"].string
            let name = $0["name"].stringValue
            let character = $0["character"].stringValue
            
            return Credit(profilePath: profilePath, name: name, character: character)
        }
        
        return [directors, cast]
    }
}
