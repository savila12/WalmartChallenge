//
//  EndPoints.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//

import Foundation

struct EndPoint {
    let scheme: String
    let host: String
    let path: String
    let query: [URLQueryItem]
}

enum EndPoints{
    case popularMovies
    case genres
    case movieDetails
}

/// Parts of url components to be used to pieced together
/// Get an example of url to make sure it is EXACTLY the same
let endPointsList: [EndPoints: EndPoint] = [
    .popularMovies: EndPoint(scheme: "https", host: "api.themoviedb.org", path: "/3/movie/popular", query: [
        URLQueryItem(name: "api_key", value: Constants.apiKey.rawValue),
        URLQueryItem(name: "language", value: "en-US"),
    ]),
    .genres: EndPoint(scheme: "https", host: "api.themoviedb.org", path: "/3/genre/movie/list", query: [
        URLQueryItem(name: "api_key", value: Constants.apiKey.rawValue),
        URLQueryItem(name: "language", value: "en-US")
    ]),
    .movieDetails: EndPoint(scheme: "https", host: "api.themoviedb.org", path: "/3/movie", query: [
        URLQueryItem(name: "api_key", value: Constants.apiKey.rawValue),
        URLQueryItem(name: "language", value: "en-US")
    ])
]
    

