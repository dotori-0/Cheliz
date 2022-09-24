//
//  TMDBAPIManager.swift
//  Cheliz
//
//  Created by SC on 2022/09/11.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    func fetchMultiSearchResults(query: String, page: Int, completionHandler: @escaping (Data) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("검색어 인코딩에 실패하였습니다.")  // 👻 alert 띄워 주기
            return
        }
        
        let url = Endpoint.multiSearchURL + APIKey.TMDB + "&language=ko-KR" + "&query=\(query)" + "&page=\(page)"
//        let url = Endpoint.multiSearchURL + APIKey.TMDB + "&language=en-US" + "&query=\(query)" + "&page=\(page)"
        // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=en-US&query=lucy&page=1&include_adult=false
        // https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&language=ko-KR&query=탑건&page=1&include_adult=false
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData { response in
            switch response.result {
                case .success(let value):
//                    let json = JSON(value)
//                    dump(json)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
