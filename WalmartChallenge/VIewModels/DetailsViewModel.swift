//
//  DetailsViewModel.swift
//  WalmartChallenge
//
//  Created by Sidney Avila on 7/22/21.
//

import Foundation

class DetailViewModel {
    /// Used to return updated mvoie object back to controller
    var delegate: DetailViewModelProtocol?
    
    /// Object to shoe on Details Controller
    var movieObject: Movie? {
        didSet {
            guard let movie = movieObject else {return}
            delegate?.didReceiveMovie(movie: movie)
        }
    }
    
    /// Function getting existing mvoie object and adding missing pieces
    /// - Parameter
    ///     - movie: Existing movie
    ///     - completion: called after movie is updated with updated movie object
    func updateMovieObject(movie: Movie, completion: @escaping (Movie)->()) {
        guard let id = movie.id else {return}
        APIHandler.shared.getData(endpoint: .movieDetails, movieId: id) { response in
            guard let response = (response as? Movie) else {return}
            var updateMovie = movie
            updateMovie.homepage = response.homepage
            updateMovie.runtime = response.runtime
            completion(updateMovie)
            
        }
    }
    
    /// Function to set movie object to view model
    /// - Parameter
    ///     - movie: movie object
    func setMovieObject(movie: Movie) {
        self.updateMovieObject(movie: movie){ movie in
            self.movieObject = movie
        }
    }
    
    /// Function to download movie image
    /// Return: data with image
    func getPoster() -> Data? {
        
        if let url = URL(string: Constants.imageUrlBase.rawValue + (self.movieObject?.poster_path ?? "")) {
            if let data = try? Data(contentsOf: url){
                return data
            }
        }
        return nil
    }
}

protocol DetailViewModelProtocol {
    func didReceiveMovie(movie: Movie)
}
