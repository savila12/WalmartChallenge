//
//  APIHandler.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/21/21.
//

import Foundation

class APIHandler {
    // Singleton
    static let shared = APIHandler()
    private init (){}
    
    
    
    ///  Function to piece together url components with Endpoints
    /// - Parameters:
    ///     - endpoint: enum with different available options for url
    ///     - page: page number to get a continuous list popular movies
    ///     - movieId: movie id to get a specific movie and its details
    ///     - return: complete url to use as a request
    func createURl (endpoint: EndPoints, page: Int? = nil, movieId: Int? = nil) -> URL? {
        
        guard let component = endPointsList[endpoint] else {return nil}
        var components = URLComponents()
        components.scheme = component.scheme
        components.host = component.host
        components.queryItems = component.query
        
        page != nil ? components.queryItems?.append(URLQueryItem(name: "page", value: String(page!))) : nil
        
        if movieId != nil {
            components.path = "\(component.path)/\(movieId!.description)"
        } else {
            components.path = component.path
        }
        
        guard let url = components.url else {
            print("ERROR: Cannot create URL")
            return nil
        }

        return url
    }
    
    /// Function to make a request and parse response
    /// - Parameters:
    ///     - endpoint: enum with different available options for url
    ///     - page: page number to get a continuous list popular movies
    ///     - movieId: movie id to get a specific movie and its details
    ///     - completion: getting one from the Models (Movie or Genres)
    func getData(endpoint: EndPoints, page: Int? = nil, movieId: Int? = nil, completion: @escaping (Shareable?)->()){
        
        guard let url = createURl(endpoint: endpoint, page: page, movieId: movieId) else { return }
       
        URLSession.shared.dataTask(with: url) {data, response , error in
            guard let data = data,
                  error == nil else { print(error?.localizedDescription ?? ""); return }
            var response: Shareable?
            
            do {
                let decoder = JSONDecoder()
                
                if endpoint == .popularMovies{
                     response = try decoder.decode(Movies.self, from: data)
                } else if endpoint == .movieDetails {
                     response = try decoder.decode(Movie.self, from: data)
                } else if endpoint == .genres {
                     response = try decoder.decode(Genres.self, from: data)
                }
                completion(response)
            } catch {
                print(error)
            }
        }.resume()
    }
}
