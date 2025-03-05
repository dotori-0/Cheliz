//
//  APIRepository.swift
//  Cheliz
//
//  Created by SC on 3/5/25.
//

import Foundation

struct APIRepository: APIRepositoryProtocol {
    private let apiManager = TMDBAPIManager.shared
    
    func fetchMultiSearchResults(query: String, page: Int, completionHandler: @escaping (Data) -> Void) {
        apiManager.fetchMultiSearchResults(query: query, page: page, completionHandler: completionHandler)
    }
    
    func fetchDetails(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void) {
        apiManager.fetchDetails(mediaType: mediaType, mediaID: mediaID, completionHandler: completionHandler)
    }
    
    func fetchGenreNames(mediaType: MediaType, completionHandler: @escaping (Data) -> Void) {
        apiManager.fetchGenreNames(mediaType: mediaType, completionHandler: completionHandler)
    }
    
    func fetchCredits(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void) {
        apiManager.fetchCredits(mediaType: mediaType, mediaID: mediaID, completionHandler: completionHandler)
    }
}
