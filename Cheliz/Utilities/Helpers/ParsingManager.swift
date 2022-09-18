//
//  ParsingManager.swift
//  Cheliz
//
//  Created by SC on 2022/09/15.
//

import Foundation
import SwiftyJSON

struct ParsingManager {
    private init() { }
    
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
        
        static func parseDataToRealmModel(_ data: Data) -> [Media] {
            let json = JSON(data)
    //        print("🐶", json)
            
            let JSONMovieAndTvOnly: [JSON] = json["results"].arrayValue.filter { $0["media_type"].stringValue != "person" }
    //        print("🐱", JSONMovieAndTvOnly)
            
            let mediaArray: [Media] = JSONMovieAndTvOnly.map { result in
                let mediaType = result["media_type"].stringValue
                
                let mediaRealmModel = Media(TMDBid: result["id"].intValue,
                                            title: mediaType == "movie" ? result["title"].stringValue : result["name"].stringValue,
//                                            title: result["title"].stringValue,
                                            mediaType: mediaType,
                                            backdropPath: result["backdrop_path"].stringValue,
                                            posterPath: result["poster_path"].stringValue,
                                            releaseDate: result["release_date"].stringValue)
                
    //            return mediaModel
                return mediaRealmModel
            }
        
        return mediaArray
    }
}
