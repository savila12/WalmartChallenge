//
//  Genres.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//

import Foundation

struct Genres: Codable, Shareable {
    let genres: [Genre]
}
struct Genre: Codable {
    let id: Int?
    let name: String?
}
