//
//  MultiSearchUseCase.swift
//  Cheliz
//
//  Created by SC on 3/5/25.
//

import Foundation

protocol MultiSearchUseCaseProtocol {
    func fetch(query: String, page: Int, completionHandler: @escaping ([Media], Int) -> Void)
}

struct MultiSearchUseCase: MultiSearchUseCaseProtocol {
    private let apiRepository: APIRepositoryProtocol
    
    init(apiRepository: APIRepositoryProtocol) {
        self.apiRepository = apiRepository
    }
    
    func fetch(query: String, page: Int, completionHandler: @escaping ([Media], Int) -> Void) {
        apiRepository.fetchMultiSearchResults(query: query, page: page) { data in
            let parsedData = ParsingManager.parseDataToRealmModel(data)
            completionHandler(parsedData.0, parsedData.1)
        }
    }
}
