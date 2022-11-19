//
//  Endpoint.swift
//  Cheliz
//
//  Created by SC on 2022/09/11.
//

import Foundation

struct Endpoint {
    private init() { }
    
    static let multiSearchURL = "https://api.themoviedb.org/3/search/multi?api_key="
    // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=en-US&query=lucy&page=1&include_adult=false
    // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=kr-KR&query=lucy&page=1&include_adult=false
    
    static let imageConfigurationURL = "https://image.tmdb.org/t/p/w500"
    // https://image.tmdb.org/t/p/w500/jMLiTgCo0vXJuwMzZGoNOUPfuj7.jpg
    // Dune: /h3HsfV8Kn9Sz2QWUYYdP5ya23hx.jpg
    static let higerResImageConfigurationURL = "https://image.tmdb.org/t/p/w1280"
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    // Detail
    // https://api.themoviedb.org/3/movie/{movie_id}?api_key=<<api_key>>&language=en-US
    // https://api.themoviedb.org/3/tv/{tv_id}?api_key=<<api_key>>&language=en-US
    
    static func detailURL(mediaType: MediaType, mediaID: Int) -> String {
        return "\(baseURL)\(mediaType.string)/\(mediaID)?api_key=\(APIKey.TMDB)&language=ko-KR"
    }
    
    
    // Genres
    // https://api.themoviedb.org/3/genre/movie/list?api_key=<<api_key>>&language=en-US
    // https://api.themoviedb.org/3/genre/tv/list?api_key=<<api_key>>&language=en-US
    static func genresURL(mediaType: MediaType) -> String {
        return "\(baseURL)/genre/\(mediaType.string)/list?api_key=\(APIKey.TMDB)&language=ko-KR"
    }
    
    // Credits
    // https://api.themoviedb.org/3/ movie/391713/credits?api_key=<<api_key>>&language=en-US
    // https://api.themoviedb.org/3/ tv/66732/credits?api_key=<<api_key>>&language=en-US
    static func creditsURL(mediaType: MediaType, mediaID: Int) -> String {
        return "\(baseURL)\(mediaType.string)/\(mediaID)/credits?api_key=\(APIKey.TMDB)"
    }
}
