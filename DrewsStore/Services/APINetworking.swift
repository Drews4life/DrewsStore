//
//  APINetworking.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import Foundation


//https://rss.itunes.apple.com/search?term=ArianaGrande&offset=\()&limit=25

class APINetworking {
    static let shared = APINetworking()
    
    func fetchItunesApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchNewGames(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
        fetchJSONData(urlString: urlString, completion: completion)
    }

    func fetchTopPaid(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchMusicPaginated(page: Int, completion: @escaping (SearchResult?, Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=ArianaGrande&offset=\(page * 20)&limit=20"
        
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                debugPrint("Error while fetching data: \(err)")
                completion(nil, err)
                return
            }
            
            if let data = data {
                do {
                    let appGroup = try JSONDecoder().decode(T.self, from: data)
                    completion(appGroup, nil)
                } catch let err {
                    completion(nil, err)
                    debugPrint("Could not decode data: \(err)")
                }
            }
        }.resume()
    }
}
