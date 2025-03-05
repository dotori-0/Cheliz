//
//  SearchViewModel.swift
//  Cheliz
//
//  Created by SC on 3/10/25.
//

import Foundation

enum SearchResultsUpdateType {
    case newSearch
    case pagination([IndexPath])
}

final class SearchViewModel {
    // MARK: - Properties
    private let multiSearchUseCase: MultiSearchUseCaseProtocol
    
    // Data
    private(set) var searchResults: [Media] = []
    
    // UI 상태
    @Published private(set) var searchResultsUpdateType: SearchResultsUpdateType?
    @Published private(set) var shouldResetScroll = false
    
    // Pagination 상태
    private var isPaginating = false
    private var page = 1
    private var totalPages = Int.zero
    private var currentQuery = String()
    
    // MARK: - Initializer
    init(multiSearchUseCase: MultiSearchUseCaseProtocol) {
        self.multiSearchUseCase = multiSearchUseCase
    }
    
    // MARK: - Methods
    func search(query: String) {
        guard !query.isEmpty else {
            shouldResetScroll = !searchResults.isEmpty
            return
        }
        
        resetPaginationState()
        currentQuery = query.lowercased()
        fetchResults()
    }
    
    func loadMoreIfNeeded(at index: Int) {
        guard shouldLoadMore(at: index) else { return }
        
        startPagination()
        fetchResults()
    }
    
    func clearResults() {
        searchResults = []
        searchResultsUpdateType = .newSearch
    }
    
    private func resetPaginationState() {
        isPaginating = false
        page = 1
    }
    
    private func startPagination() {
        isPaginating = true
        page += 1
    }
    
    private func shouldLoadMore(at index: Int) -> Bool {
        searchResults.count - 1 == index && page < totalPages
    }
    
    private func fetchResults() {
        multiSearchUseCase.fetch(query: currentQuery, page: page) { [weak self] results, totalPages in
            guard let self = self else { return }
            
            if self.isPaginating {
                self.handlePaginationResults(results)
            } else {
                self.handleNewSearchResults(results, totalPages: totalPages)
            }
        }
    }
    
    private func handlePaginationResults(_ results: [Media]) {
        let startIndex = searchResults.count  // 기존 데이터 개수
        searchResults.append(contentsOf: results)
        let endIndex = searchResults.count - 1 // 업데이트 후의 마지막 인덱스
        let newIndexPaths = (startIndex...endIndex).map { IndexPath(item: $0, section: 0) }
        searchResultsUpdateType = .pagination(newIndexPaths)
    }
    
    private func handleNewSearchResults(_ results: [Media], totalPages: Int) {
        searchResults = results
        self.totalPages = totalPages
        searchResultsUpdateType = .newSearch
    }
}
