//
//  TMDBAPIManager.swift
//  Cheliz
//
//  Created by SC on 2022/09/11.
//

import Foundation

import Alamofire
import SwiftyJSON

final class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    func fetchMultiSearchResults(query: String, page: Int, completionHandler: @escaping (Data) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("검색어 인코딩에 실패하였습니다.")  // 👻 alert 띄워 주기
            return
        }
        
        let url = Endpoint.multiSearchURL + APIKey.TMDB + "&language=ko-KR" + "&query=\(query)" + "&page=\(page)" + "&include_adult=false"
//        let url = Endpoint.multiSearchURL + APIKey.TMDB + "&language=en-US" + "&query=\(query)" + "&page=\(page)"
        // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=en-US&query=lucy&page=1&include_adult=false
        // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=ko-KR&query=탑건&page=1&include_adult=false
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { response in
            switch response.result {
                case .success(let data):
//                    let json = JSON(value)
//                    dump(json)
                    completionHandler(data)
                case .failure(let error):
                    print(error)  // 👻 에러 핸들러
            }
        }
    }
    
    func fetchDetails(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void) {
        let url = Endpoint.detailURL(mediaType: mediaType, mediaID: mediaID)  // ❔👻 이렇게 하는 것과 위 fetchMultiSearchResults에서 쓴 방법 중 뭐가 더 나은 건지?
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { response in
            switch response.result {
                case .success(let data):
                    completionHandler(data)
                case.failure(let error):
                    print(error)  // 👻 에러 핸들러
            }
        }
    }
    
    // 일단 한국어/영어는 로컬로 저장 -> 추후 다국어 대응 시 API로 구현
    func fetchGenreNames(mediaType: MediaType, completionHandler: @escaping (Data) -> Void) {
        let url = Endpoint.genresURL(mediaType: mediaType)
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { respose in
            switch respose.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(error)  // 👻 에러 핸들러
            }
        }
    }
    
    func fetchCredits(mediaType: MediaType, mediaID: Int, completionHandler: @escaping (Data) -> Void) {
        let url = Endpoint.creditsURL(mediaType: mediaType, mediaID: mediaID)
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { response in
            switch response.result {
                case .success(let data):
                    completionHandler(data)
                case.failure(let error):
                    print(error)  // 👻 에러 핸들러
            }
        }
    }
}
