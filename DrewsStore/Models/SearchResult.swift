//
//  SearchResult.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/20/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let artworkUrl100: String //appicon
    let description: String
    let screenshotUrls: [String]
    
    var averageUserRating: Float?
    var formattedPrice: String?
    var releaseNotes: String?
}

