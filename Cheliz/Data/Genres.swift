//
//  Genres.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import Foundation

struct Genres {
    private init() { }
    
    static var language: String = ""
    static var mediaType: MediaType = .movie
    static var id: Int = 0
    
    static func setLanguage(as language: String) {
        self.language = language
    }
    
    static func setMediaType(as mediaType: MediaType) {
        self.mediaType = mediaType
    }
    
    static func fetchName(of id: Int) -> String {
        self.id = id
        return name
    }
    
    static var name: String {
        get {
            if mediaType == .movie {
                switch id {
                    case 28: return MovieGenre.action
                    case 12: return "모험"
                    default: return ""
                }
            } else {
                return ""
            }
        }
    }
}


enum MovieGenre {
    static let action = "액션"
    static let adventure = "모험"
}


