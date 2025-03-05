//
//  SearchResultMediaAdditionUseCase.swift
//  Cheliz
//
//  Created by SC on 3/17/25.
//

import Foundation

protocol SearchResultMediaAdditionUseCaseProtocol {
    func add(media: Media) async throws
}

struct SearchResultMediaAdditionUseCase: SearchResultMediaAdditionUseCaseProtocol {
    private let mediaRepository: RealmRepositoryProtocol
    
    init(mediaRepository: RealmRepositoryProtocol) {
        self.mediaRepository = mediaRepository
    }
    
    @MainActor
    func add(media: Media) async throws {
        if mediaRepository.sameMediaExists(as: media) {
            throw MediaAdditionError.alreadyExists
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            mediaRepository.add(media: media) {
                continuation.resume()
            } errorHandler: {
                continuation.resume(throwing: MediaAdditionError.databaseError)
            }
        }
    }
}
