//
//  SearchResultMediaAdditionViewModel.swift
//  Cheliz
//
//  Created by SC on 3/17/25.
//

import Foundation

final class SearchResultMediaAdditionViewModel {
    // MARK: - Properties
    private let useCase: SearchResultMediaAdditionUseCaseProtocol
    
    @Published private(set) var additionResult: Result<Void, MediaAdditionError>?
    
    // MARK: - Initializers
    init(useCase: SearchResultMediaAdditionUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func add(media: Media) {
        Task {
            do {
                try await useCase.add(media: media)
                additionResult = .success(())
            } catch let error as MediaAdditionError {
                additionResult = .failure(error)
            } catch {
                additionResult = .failure(.unknown)
            }
        }
    }
    
    func resetAdditionResult() {
        additionResult = nil
    }
}
