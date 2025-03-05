//
//  APIRepositoryProtocol.swift
//  Cheliz
//
//  Created by SC on 3/5/25.
//

import Foundation

protocol APIRepositoryProtocol {
    func fetchMultiSearchResults(query: String, page: Int, completionHandler: @escaping (Data) -> Void)
    func fetchDetails(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void)
    func fetchGenreNames(mediaType: MediaType, completionHandler: @escaping (Data) -> Void)
    func fetchCredits(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void)
}
