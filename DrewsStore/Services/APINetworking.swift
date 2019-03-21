//
//  APINetworking.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import Foundation

class APINetworking {
    static let shared = APINetworking()
    
    func fetchItunesApps(searchTerm: String, completion: @escaping ([Result], Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                debugPrint("Could not fetch apps: \(err.localizedDescription)")
                completion([], err)
                return
            }
            
            if let data = data {
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(searchResult.results, nil)
                } catch let err {
                    debugPrint("Could not decode search results: \(err.localizedDescription)")
                    completion([], err)
                }
            }
            
            }.resume()
    }
    
    func fetchGames(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchNewGames(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (ApplicationGroup?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                debugPrint("Error while fetching games: \(err.localizedDescription)")
                completion(nil, err)
                return
            }
            
            if let data = data {
                do {
                    let appGroup = try JSONDecoder().decode(ApplicationGroup.self, from: data)
                    completion(appGroup, nil)
                } catch let err {
                    completion(nil, err)
                    debugPrint("Could not decode games: \(err.localizedDescription)")
                }
            }
        }.resume()
    }
}