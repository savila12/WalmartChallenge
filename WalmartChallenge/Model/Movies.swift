//
//  Movies.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//

import Foundation

//All models are conformed to this protocol so that the comepletion handler and use this as a parameter and then later type cast to any specific model type if needed
protocol Shareable {}


struct Movies: Codable, Shareable {
    let results: [Movie]?
}

struct Movie: Codable, Shareable {
    let genre_ids: [Int]?
    let id: Int?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let popularity: Double?
    var runtime: Int? = nil
    var homepage: String? = nil
    var overview: String? = nil
    var movieLink: String? = nil
    let genre: Genre?
}


