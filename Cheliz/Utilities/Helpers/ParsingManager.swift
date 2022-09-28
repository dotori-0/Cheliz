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
                
//                let releaseDate = mediaType == "movie" ? result["release_date"].stringValue : result["first_air_date"].stringValue
                let releaseDate = result[mediaType == MediaType.movie.rawValue ? "release_date" : "first_air_date"].stringValue
                
                let mediaRealmModel = Media(TMDBid: result["id"].intValue,
                                            title: title,
                                            mediaType: mediaType,
                                            genreIds: genreIds,
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
}
